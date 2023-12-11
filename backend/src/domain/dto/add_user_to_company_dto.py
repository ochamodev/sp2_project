from typing import ClassVar, Type

from marshmallow_dataclass import dataclass
from marshmallow import Schema


@dataclass
class AddUserToCompanyDTO:
    userEmail: str
    userName: str
    userPassword: str
    userLastName: str
    searchByUser: bool
    companyId: int
    Schema: ClassVar[Type[Schema]] = Schema
