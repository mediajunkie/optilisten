import { Grid, Hidden } from "@mui/material";
import IconButton from "@mui/material/IconButton";

import { FC } from "react";

import Logo from "../assets/images/logo.png";
import AppStore from "../assets/images/ios.png";
import Hamburger from "../assets/images/hamburger.png";
import { useNavigate } from "react-router-dom";
import { PATH_ABOUT, PATH_FEEDBACK, PATH_PRIVACY } from "../routes/paths";

interface Props {
  toggleDrawer: (show: boolean) => void;
}

export const Header: FC<Props> = ({ toggleDrawer }) => {
  const navigate = useNavigate();

  return (
    <div className="px-20 py-8 relative">
      <Grid container>
        <Hidden mdUp>
          <Grid item xs={12} sm={12}>
            <div className="flex justify-center items-center">
              <div className="absolute left-8">
                <IconButton
                  color="primary"
                  aria-label="upload picture"
                  component="label"
                  onClick={() => toggleDrawer(true)}
                >
                  <img src={Hamburger} alt="Menu" width={32} />
                </IconButton>
              </div>
              <img src={Logo} alt="Logo" width={67} />
            </div>
          </Grid>
        </Hidden>
        <Hidden mdDown>
          <Grid item md={12} lg={12}>
            <div className="flex justify-between items-center">
              <div className="flex items-center">
                <img src={Logo} alt="Logo" width={67} />
                <h1 className="pl-2 font-dosis-bold text-darkBlue text-2xl">
                  OptiListen
                </h1>
              </div>
              <div className="flex items-center">
                <p
                  className="mr-6 text-xl font-sfpro-bold text-darkBlue underline underline-offset-4 cursor-pointer"
                  onClick={() => {
                    navigate(PATH_ABOUT);
                  }}
                >
                  About
                </p>
                <p
                  className="mr-6 text-xl font-sfpro-bold text-darkBlue underline underline-offset-4 cursor-pointer"
                  onClick={() => {
                    navigate(PATH_FEEDBACK);
                  }}
                >
                  Feedback
                </p>
                <p
                  className="text-xl mr-6 font-sfpro-bold text-darkBlue underline underline-offset-4 cursor-pointer"
                  onClick={() => {
                    navigate(PATH_PRIVACY);
                  }}
                >
                  Privacy
                </p>
                <img
                  src={AppStore}
                  alt="AppStore"
                  width={118}
                  className="cursor-pointer"
                />
              </div>
            </div>
          </Grid>
        </Hidden>
      </Grid>
    </div>
  );
};
