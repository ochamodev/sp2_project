
from decimal import Decimal
from typing import ClassVar, Type, List, Dict

from marshmallow_dataclass import dataclass
from marshmallow import Schema


@dataclass
class YearFilterDTO:
    year: int


@dataclass
class SalesPerformanceItemDTO:
    amount: Decimal
    quantity: int
    yearT: int
    Schema: ClassVar[Type[Schema]] = Schema


@dataclass
class MonthlySalesPerYearItemDTO:
    amount: Decimal
    quantity: int
    yearT: int
    monthT: int
    Schema: ClassVar[Type[Schema]] = Schema


@dataclass
class MonthlyStandardDeviationDTO:
    amount: Decimal
    yearT: int
    monthT: int
    Schema: ClassVar[Type[Schema]] = Schema


@dataclass
class MonthlySalesPerYearDTO:
    yearT: int
    items: List[MonthlySalesPerYearItemDTO]
    Schema: ClassVar[Type[Schema]] = Schema


@dataclass
class SalesPerformanceDTO:
    yearFilters: List[YearFilterDTO]
    salesPerformanceElements: List[SalesPerformanceItemDTO]
    monthlySalesPerYear: Dict
    monthlyStandardDeviation: Dict
    Schema: ClassVar[Type[Schema]] = Schema
