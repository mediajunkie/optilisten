import { FC } from "react";
import { Route, Routes } from "react-router-dom";
import { AboutPage } from "../pages/About";
import { FeedbackPage } from "../pages/Feedback";
import { NotFoundPage } from "../pages/NotFound";
import { PrivacyPage } from "../pages/Privacy";
import {
  PATH_ABOUT,
  PATH_ANY,
  PATH_FEEDBACK,
  PATH_PRIVACY,
  PATH_ROOT,
} from "./paths";

export const AppRoutes: FC = () => {
  return (
    <Routes>
      <Route path={PATH_ROOT} element={<AboutPage />} />
      <Route path={PATH_ABOUT} element={<AboutPage />} />
      <Route path={PATH_FEEDBACK} element={<FeedbackPage />} />
      <Route path={PATH_PRIVACY} element={<PrivacyPage />} />
      <Route path={PATH_ANY} element={<NotFoundPage />} />
    </Routes>
  );
};
