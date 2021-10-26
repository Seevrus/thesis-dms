import axios from 'axios';
import { createAsyncThunk, createEntityAdapter, createSlice } from '@reduxjs/toolkit';

// eslint-disable-next-line import/no-cycle
import { RootState } from './store';
import { BaseResponseT } from './commonTypes';
import { OtherUserT, SearchUserRequestT, SearchUserResponseT } from './otherUsersSliceTypes';

const otherUsersAdapter = createEntityAdapter<OtherUserT>({
  selectId: (state) => state.taxNumber,
});
const initialState = otherUsersAdapter.getInitialState();

export const searchUsers = createAsyncThunk<
SearchUserResponseT, SearchUserRequestT, { rejectValue: BaseResponseT }
>(
  'otherUsers/searchUsers',
  async (keyword, { rejectWithValue }) => {
    try {
      const response = await axios.get(`/api/user/handle/search.php?keyword=${keyword}`);
      return response.data;
    } catch (e) {
      return rejectWithValue(e.response.data);
    }
  },
);

const otherUsersSlice = createSlice({
  name: 'otherUsers',
  initialState,
  reducers: {},
  extraReducers: (builder) => {
    builder.addCase(searchUsers.fulfilled, (state, { payload }) => {
      otherUsersAdapter.setMany(state, payload.users);
    });
  },
});

export const {
  selectAll: selectUsers,
} = otherUsersAdapter.getSelectors((state: RootState) => state.otherUsers);

export default otherUsersSlice.reducer;
