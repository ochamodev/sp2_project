from typing import ClassVar, Type

from marshmallow_dataclass import dataclass
from marshmallow import Schema

@dataclass
class BaseResponseDTO:
    success: bool
    data: {}
    Schema: ClassVar[Type[Schema]] = Schema
