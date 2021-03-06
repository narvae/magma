#!/usr/bin/env python3
# @generated AUTOGENERATED file. Do not Change!

from dataclasses import dataclass
from datetime import datetime
from gql.gql.datetime_utils import DATETIME_FIELD
from gql.gql.graphql_client import GraphqlClient
from functools import partial
from numbers import Number
from typing import Any, Callable, List, Mapping, Optional

from dataclasses_json import DataClassJsonMixin

from .equipment_port_definition_fragment import EquipmentPortDefinitionFragment, QUERY as EquipmentPortDefinitionFragmentQuery
from .equipment_position_definition_fragment import EquipmentPositionDefinitionFragment, QUERY as EquipmentPositionDefinitionFragmentQuery
from .property_type_fragment import PropertyTypeFragment, QUERY as PropertyTypeFragmentQuery
from .add_equipment_type_input import AddEquipmentTypeInput


QUERY: List[str] = EquipmentPortDefinitionFragmentQuery + EquipmentPositionDefinitionFragmentQuery + PropertyTypeFragmentQuery + ["""
mutation AddEquipmentTypeMutation($input: AddEquipmentTypeInput!) {
  addEquipmentType(input: $input) {
    id
    name
    category
    propertyTypes {
      ...PropertyTypeFragment
    }
    positionDefinitions {
      ...EquipmentPositionDefinitionFragment
    }
    portDefinitions {
      ...EquipmentPortDefinitionFragment
    }
  }
}

"""]

@dataclass
class AddEquipmentTypeMutation(DataClassJsonMixin):
    @dataclass
    class AddEquipmentTypeMutationData(DataClassJsonMixin):
        @dataclass
        class EquipmentType(DataClassJsonMixin):
            @dataclass
            class PropertyType(PropertyTypeFragment):
                pass

            @dataclass
            class EquipmentPositionDefinition(EquipmentPositionDefinitionFragment):
                pass

            @dataclass
            class EquipmentPortDefinition(EquipmentPortDefinitionFragment):
                pass

            id: str
            name: str
            propertyTypes: List[PropertyType]
            positionDefinitions: List[EquipmentPositionDefinition]
            portDefinitions: List[EquipmentPortDefinition]
            category: Optional[str]

        addEquipmentType: EquipmentType

    data: AddEquipmentTypeMutationData

    @classmethod
    # fmt: off
    def execute(cls, client: GraphqlClient, input: AddEquipmentTypeInput) -> AddEquipmentTypeMutationData:
        # fmt: off
        variables = {"input": input}
        response_text = client.call(''.join(set(QUERY)), variables=variables)
        return cls.from_json(response_text).data
