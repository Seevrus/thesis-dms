/* eslint-disable import/no-cycle */
import { configureStore } from '@reduxjs/toolkit';

import activityFilterSlice from './activityFilterSlice';
import documentsSlice from './documentsSlice';
import otherUsersSlice from './otherUsersSlice';
import userActivityScile from './userActivitySlice';
import userSlice from './userSlice';

const store = configureStore({
  reducer: {
    activityFilter: activityFilterSlice,
    documents: documentsSlice,
    otherUsers: otherUsersSlice,
    userActivity: userActivityScile,
    user: userSlice,
  },
});

export default store;

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
