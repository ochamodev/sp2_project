from typing import ClassVar, Type

from marshmallow_dataclass import dataclass
from marshmallow import Schema


@dataclass
class ChangePasswordDTO:
    userEmail: str
    oldPassword: str
    newPassword: str
    Schema: ClassVar[Type[Schema]] = Schema
