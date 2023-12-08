from decimal import Decimal
from typing import ClassVar, Type, List, Dict

from marshmallow_dataclass import dataclass
from marshmallow import Schema

@dataclass
class RFCItemDTO:
    idReceptor: int
    name: str
    # amount: Decimal
    rfm_score: Decimal
    recency: Decimal
    frequency: Decimal
    monetary: Decimal
    cluster: int
    cluster_name: str


@dataclass
class RFCDTO:
    premium: List[RFCItemDTO]
    potential: List[RFCItemDTO]
    sporadic: List[RFCItemDTO]
    Schema: ClassVar[Type[Schema]] = Schema