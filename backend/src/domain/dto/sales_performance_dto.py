
from decimal import Decimal
from typing import ClassVar, Type

from marshmallow_dataclass import dataclass
from marshmallow import Schema


@dataclass
class SalesPerformanceDTO:
    amount: Decimal
    quantity: int
    yearT: int
    Schema: ClassVar[Type[Schema]] = Schema
