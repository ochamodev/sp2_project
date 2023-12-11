from typing import ClassVar, Type

from marshmallow_dataclass import dataclass
from marshmallow import Schema


@dataclass
class DeleteUserFromCompanyDTO:
    userId: int
    companyId: int
    Schema: ClassVar[Type[Schema]] = Schema
