from typing import ClassVar, Type

from marshmallow_dataclass import dataclass
from marshmallow import Schema


@dataclass
class CompanyDTO:
    id: int
    nit: str
    nameEmitter: str
    Schema: ClassVar[Type[Schema]] = Schema
