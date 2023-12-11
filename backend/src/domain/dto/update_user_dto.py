from typing import ClassVar, Type

from marshmallow_dataclass import dataclass
from marshmallow import Schema


@dataclass
class UpdateUserDTO:
    userEmail: str
    userName: str
    userLastName: str
    Schema: ClassVar[Type[Schema]] = Schema
