import { createAsyncThunk, createEntityAdapter, createSlice } from '@reduxjs/toolkit';
import axios from 'axios';
import { BaseResponseT } from './commonTypes';
// eslint-disable-next-line import/no-cycle
import { RootState } from './store';
import { UserActivityRequestT, UserActivityT } from './userActivitySliceTypes';

const userActivityAdapter = createEntityAdapter<UserActivityT>();
const initialState = userActivityAdapter.getInitialState();

export const fetchColumnOptions = async (columnName: keyof UserActivityRequestT) => {
  try {
    const response = await axios.post('/api/user/activity/options.php', { columnName });
    return response.data.options as string[];
  } catch (e) {
    throw new Error(e.data.message);
  }
};

export const listUserActivity = createAsyncThunk(
  'userActivity/listUserActivity',
  async (requestData: UserActivityRequestT, { rejectWithValue }) => {
    try {
      const response = await axios.post('/api/user/activity/list.php', requestData);
      return response.data.activities as UserActivityT[];
    } catch (e) {
      return rejectWithValue(e.response.data as BaseResponseT);
    }
  },
);

const userActivitySlice = createSlice({
  name: 'userActivity',
  initialState,
  reducers: {},
  extraReducers: (builder) => {
    builder.addCase(listUserActivity.fulfilled, userActivityAdapter.setAll);
  },
});

export const {
  selectAll: selectActivities,
} = userActivityAdapter.getSelectors((state: RootState) => state.userActivity);

export default userActivitySlice.reducer;
