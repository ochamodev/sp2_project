from decimal import Decimal
from typing import ClassVar, Type, List, Dict

from marshmallow_dataclass import dataclass
from marshmallow import Schema


@dataclass
class CustomerLifetimeValueResponseDTO:
    # general info
    totalClients: int
    avgMonthActive: Decimal
    avgPurchase: Decimal
    avgFrequencyMonth: Decimal
    customerValuePerYear: Dict
    Schema: ClassVar[Type[Schema]] = Schema
    # general info


@dataclass
class CustomerLifetimeValueItemDTO:
    monthT: int
    amount: Decimal
    clientCount: int
    quantity: int
    customerValue: Decimal
    purchaseRate: Decimal
    purchaseValue: Decimal
