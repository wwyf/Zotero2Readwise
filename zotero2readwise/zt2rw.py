from typing import Dict, List

from zotero2readwise.readwise import Readwise
from zotero2readwise.zotero import (
    ZoteroAnnotationsNotes,
    get_zotero_client,
)


class Zotero2Readwise:
    def __init__(
        self,
        readwise_token: str,
        zotero_key: str,
        zotero_library_id: str,
        zotero_library_type: str = "user",
        include_annotations: bool = True,
        include_notes: bool = False,
        version_number: int = None,
        latest_version_number: int = None
    ):
        self.readwise = Readwise(readwise_token)
        self.zotero_client = get_zotero_client(
            library_id=zotero_library_id,
            library_type=zotero_library_type,
            api_key=zotero_key,
        )
        self.zotero = ZoteroAnnotationsNotes(self.zotero_client)
        self.include_annots = include_annotations
        self.include_notes = include_notes
        self.version_number = version_number
        self.latest_version_number = latest_version_number

    def get_all_zotero_items(self) -> List[Dict]:
        annots, notes = [], []
        if self.include_annots:
            annots = self.zotero.retrieve_all_annotations(self.version_number)
        for annot in annots:
            print(annot)
        if (len(annots)) > 0:
            self.latest_version_number = annots[0]['data']['version']
        else:
            self.latest_version_number = self.version_number

        # if self.include_notes:
        #     notes = self.zotero.retrieve_all_annotations(self.version_number)

        all_zotero_items = annots + notes
        print(f"{len(all_zotero_items)} Zotero items are retrieved.")

        return all_zotero_items

    def run(self, zot_annots_notes: List[Dict] = None) -> None:
        if zot_annots_notes is None:
            zot_annots_notes = self.get_all_zotero_items()

        formatted_items = self.zotero.format_items(zot_annots_notes)
        if (self.latest_version_number == self.version_number):
            print("No new items to update")
            print(f"Latest_version_number : ")
            print(f"{self.latest_version_number}")
            return

        if self.zotero.failed_items:
            self.zotero.save_failed_items_to_json("failed_zotero_items.json")

        self.readwise.post_zotero_annotations_to_readwise(formatted_items)
        print(f"Latest_version_number : ")
        print(f"{self.latest_version_number}")

