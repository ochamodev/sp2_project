from typing import ClassVar, Type, Dict, Any

from marshmallow_dataclass import dataclass
from marshmallow import Schema

@dataclass
class BaseResponseDTO:
    success: bool
    data: Dict[str, Any]
    Schema: ClassVar[Type[Schema]] = Schema
