from typing import ClassVar, Type

from marshmallow_dataclass import dataclass
from marshmallow import Schema


@dataclass
class UserDTO:
    id: int
    userName: str
    userLastName: str
    userEmail: str
    Schema: ClassVar[Type[Schema]] = Schema
