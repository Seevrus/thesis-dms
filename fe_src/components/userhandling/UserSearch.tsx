import { map } from 'ramda';
import { useEffect, useState } from 'react';
import {
  Col,
  Container,
  Row,
} from 'react-bootstrap';
import Select from 'react-select';
import makeAnimated from 'react-select/animated';

import debounce from '../utils/debounce';
import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { OtherUserT, UserSearchTypeEnum } from '../../store/otherUsers/otherUsersSliceTypes';
import {
  searchUsers,
  selectSearchResults,
  selectSelectedUser,
  setUser,
} from '../../store/otherUsers/otherUsersSlice';
import { OptionsT } from '../../interfaces/common';

const animatedComponents = makeAnimated();

const UserSearch = () => {
  const dispatch = useAppDispatch();

  const users = useAppSelector(selectSearchResults);
  const selectedUser = useAppSelector(selectSelectedUser);
  const [userOptions, setUserOptions] = useState<OptionsT[]>();
  const [activeOption, setActiveOption] = useState<OptionsT>(undefined);

  useEffect(
    () => {
      dispatch(searchUsers({
        keyword: '',
        searchType: UserSearchTypeEnum.ALL,
      }));
    }, [dispatch],
  );

  useEffect(() => {
    setUserOptions(
      map((user: OtherUserT): OptionsT => ({
        label: `${user.taxNumber}: ${user.userRealName} (${user.userEmail ?? '-'})`,
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
    dispatch(searchUsers({
      keyword,
      searchType: UserSearchTypeEnum.ALL,
    }));
  };

  return (
    <Container className="mt-5 mb-5">
      <Row>
        <Col>
          <Select
            className="filter-list-dropdown"
            closeMenuOnSelect
            components={animatedComponents}
            isMulti={false}
            isSearchable
            noOptionsMessage={() => 'Nincs több találat'}
            onChange={handleChange}
            onInputChange={debounce(handleInputChange, 500)}
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
