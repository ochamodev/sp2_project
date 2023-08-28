from typing import ClassVar, Type

from marshmallow_dataclass import dataclass
from marshmallow import Schema

@dataclass
class LoginDTO:
    email: str
    password: str
    Schema: ClassVar[Type[Schema]] = Schema
