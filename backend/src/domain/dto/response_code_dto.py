from typing import ClassVar, Type

from marshmallow_dataclass import dataclass
from marshmallow import Schema


@dataclass
class ResponseCodeDTO:
    respCode: str
    respDescription: str
    Schema: ClassVar[Type[Schema]] = Schema
