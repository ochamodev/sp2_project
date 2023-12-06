from typing import ClassVar, Type

from marshmallow_dataclass import dataclass
from marshmallow import Schema


@dataclass
class SelectedCompanyDTO:
    currentCompany: int
    Schema: ClassVar[Type[Schema]] = Schema
