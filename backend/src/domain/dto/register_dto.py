from typing import ClassVar, Type

from marshmallow_dataclass import dataclass
from marshmallow import Schema

@dataclass
class RegisterDTO:
    userEmail: str
    password: str
    name: str
    lastName: str
    nitEmpresa: str
    nameEmpresa: str
    Schema: ClassVar[Type[Schema]] = Schema
