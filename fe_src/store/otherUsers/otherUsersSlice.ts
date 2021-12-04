/* eslint-disable no-param-reassign */
import axios from 'axios';
import { forEach } from 'ramda';
import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

// eslint-disable-next-line import/no-cycle
import { RootState } from '../store';
import { BaseResponseT } from '../commonTypes';
import {
  FetchCompaniesResponseT,
  OtherUsersSliceT,
  SearchUserRequestT,
  SearchUserResponseT,
} from './otherUsersSliceTypes';
import { UpdateProfileRequestT, UpdateProfileResponseT } from '../user/userSliceTypes';
import { checkUpdateProfileResponseForErrors } from '../helpers';

const initialState: OtherUsersSliceT = {
  companies: [],
  searchResults: [],
  selectedUser: undefined,
};

export const searchUsers = createAsyncThunk<
SearchUserResponseT, SearchUserRequestT, { rejectValue: BaseResponseT }
>(
  'otherUsers/searchUsers',
  async (requestData, { rejectWithValue }) => {
    try {
      const response = await axios.post('/api/user/handle/search.php', requestData);
      return response.data;
    } catch (e) {
      return rejectWithValue(e.response.data);
    }
  },
);

export const fetchCompanies = createAsyncThunk<
FetchCompaniesResponseT, null, { rejectValue: BaseResponseT }
>(
  'otherUsers/selectCompanies',
  async (_, { rejectWithValue }) => {
    try {
      const response = await axios.get('api/company/search.php');
      return response.data;
    } catch (e) {
      return rejectWithValue(e.response.data);
    }
  },
);

export const updateUser = createAsyncThunk<
UpdateProfileResponseT,
UpdateProfileRequestT,
{ rejectValue: BaseResponseT }
>(
  'otherUsers/updateUser',
  async (requestData, { rejectWithValue }) => {
    try {
      const response = await axios.post('/api/user/update.php', requestData);
      // TODO: I do not really handle partial errors other than displaying them
      const errors = checkUpdateProfileResponseForErrors(response);
      if (errors) {
        return rejectWithValue({
          outcome: 'failure',
          message: errors,
        });
      }
      return response.data;
    } catch (e) {
      return rejectWithValue(e.response.data);
    }
  },
);

const otherUsersSlice = createSlice({
  name: 'otherUsers',
  initialState,
  reducers: {
    setUser: (state, action) => {
      const userTaxNumber: number = action.payload;
      state.selectedUser = state.searchResults.find(
        (user) => user.taxNumber === userTaxNumber,
      );
    },
  },
  extraReducers: (builder) => {
    builder.addCase(searchUsers.fulfilled, (state, { payload }) => {
      state.searchResults = payload.users;
    });

    builder.addCase(fetchCompanies.fulfilled, (state, { payload }) => {
      state.companies = payload.companies;
    });

    builder.addCase(updateUser.fulfilled, (state, { payload }) => {
      forEach((payloadElement) => {
        if (payloadElement.outcome === 'success') {
          state.selectedUser[payloadElement.value] = payloadElement[payloadElement.value];
        }
      }, payload);
    });

    builder.addCase(updateUser.rejected, (_, { payload }) => {
      throw new Error(payload.message || 'API returned an error');
    });
  },
});

export const selectCompanies = (state: RootState) => state.otherUsers.companies;
export const selectSearchResults = (state: RootState) => state.otherUsers.searchResults;
export const selectSelectedUser = (state: RootState) => state.otherUsers.selectedUser;

export const { setUser } = otherUsersSlice.actions;

export default otherUsersSlice.reducer;
