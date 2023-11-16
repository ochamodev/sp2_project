from decimal import Decimal
from typing import ClassVar, Type, List, Dict

from marshmallow_dataclass import dataclass
from marshmallow import Schema


@dataclass
class CustomerRetentionResponseDTO:
    # general info
    customerRetentionPerYear: Dict
    Schema: ClassVar[Type[Schema]] = Schema
    # general info


@dataclass
class CustomerRetentionRateItemDTO:
    yearT: int
    monthT: int
    newClients: int
    newAmount: Decimal
    cancelledClients: int
    cancelledAmount: Decimal
    retainedClients: int
    retainedAmount: Decimal
    customerRetention: Decimal



