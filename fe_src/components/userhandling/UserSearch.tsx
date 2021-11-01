import { map } from 'ramda';
import { useEffect, useState } from 'react';
import {
  Col,
  Container,
  Row,
} from 'react-bootstrap';
import Select from 'react-select';
import makeAnimated from 'react-select/animated';

import { OtherUserT } from 'store/otherUsersSliceTypes';
import {
  searchUsers,
  selectSearchResults,
  selectSelectedUser,
  setUser,
} from '../../store/otherUsersSlice';
import { OptionsT } from '../../interfaces/common';
import { useAppDispatch, useAppSelector } from '../../store/hooks';
import debounce from '../utils/debounce';

const animatedComponents = makeAnimated();

const UserSearch = () => {
  const dispatch = useAppDispatch();

  const users = useAppSelector(selectSearchResults);
  const selectedUser = useAppSelector(selectSelectedUser);
  const [userOptions, setUserOptions] = useState<OptionsT[]>();
  const [activeOption, setActiveOption] = useState<OptionsT>(undefined);

  useEffect(
    () => {
      dispatch(searchUsers(''));
    }, [dispatch],
  );

  useEffect(() => {
    setUserOptions(
      map((user: OtherUserT): OptionsT => ({
        label: user.userRealName,
        value: String(user.taxNumber),
      }), users),
    );
  },
  [users]);

  useEffect(() => {
    if (selectedUser) {
      setActiveOption({
        label: selectedUser.userRealName,
        value: String(selectedUser.taxNumber),
      });
    }
  }, [selectedUser]);

  const handleChange = (user: OptionsT) => {
    const userTaxNumber = Number(user.value);
    dispatch(setUser(userTaxNumber));
  };

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
            onChange={handleChange}
            onInputChange={debounce(handleInputChange)}
            options={userOptions}
            placeholder="Felhasználó keresése..."
            value={activeOption}
          />
        </Col>
      </Row>
    </Container>
  );
};

export default UserSearch;
