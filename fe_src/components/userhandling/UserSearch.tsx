import { map } from 'ramda';
import * as React from 'react';
import {
  Col,
  Container,
  Row,
} from 'react-bootstrap';
import Select from 'react-select';
import makeAnimated from 'react-select/animated';

import { OtherUserT } from 'store/otherUsersSliceTypes';
import { searchUsers, selectUsers } from '../../store/otherUsersSlice';
import { OptionsT } from '../../interfaces/common';
import { useAppDispatch, useAppSelector } from '../../store/hooks';
import debounce from '../utils/debounce';

const { useEffect, useState } = React;
const animatedComponents = makeAnimated();

const UserSearch = () => {
  const dispatch = useAppDispatch();

  const users = useAppSelector(selectUsers);
  const [userOptions, setUserOptions] = useState<OptionsT[]>();

  useEffect(() => {
    setUserOptions(
      map((user: OtherUserT): OptionsT => ({
        label: user.userRealName,
        value: String(user.taxNumber),
      }), users),
    );
  },
  [users]);

  const handleInputChange = (keyword: string) => {
    if (keyword) dispatch(searchUsers(keyword));
  };

  return (
    <Container className="mt-5 mb-5">
      <Row>
        <Col>
          <Select
            className="filter-list-dropdown"
            closeMenuOnSelect
            components={animatedComponents}
            noOptionsMessage={() => 'Nincs több találat'}
            onInputChange={debounce(handleInputChange)}
            options={userOptions}
            placeholder="Felhasználó keresése..."
          />
        </Col>
      </Row>
    </Container>
  );
};

export default UserSearch;
