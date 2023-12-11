from decimal import Decimal
from typing import ClassVar, Type, List, Dict

from marshmallow_dataclass import dataclass
from marshmallow import Schema

@dataclass
class RFCItemDTO:
    idReceptor: int
    name: str
    rfmScore: Decimal
    recency: Decimal
    frequency: Decimal
    monetary: Decimal
    cluster: int
    clusterName: str

@dataclass
class RFCDTO:
    avgFrequency: Decimal
    avgRecency: Decimal
    avgMonetary: Decimal
    customerClusters: Dict
    Schema: ClassVar[Type[Schema]] = Schema