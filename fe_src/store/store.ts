/* eslint-disable import/no-cycle */
import { configureStore } from '@reduxjs/toolkit';

import activityFilterSlice from './activityFilter/activityFilterSlice';
import documentsSlice from './documents/documentsSlice';
import otherUsersSlice from './otherUsers/otherUsersSlice';
import statisticsSlice from './statistics/statisticsSlice';
import userActivityScile from './userActivity/userActivitySlice';
import userSlice from './user/userSlice';

const store = configureStore({
  reducer: {
    activityFilter: activityFilterSlice,
    documents: documentsSlice,
    otherUsers: otherUsersSlice,
    statistics: statisticsSlice,
    userActivity: userActivityScile,
    user: userSlice,
  },
});

export default store;

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
