import { Grid, Hidden } from "@mui/material";
import { FC } from "react";
import Logo from "../assets/images/logo.png";
import AppStore from "../assets/images/iosLight.png";
import LinkedIn from "../assets/images/LinkedInDark.png";
import Twitter from "../assets/images/TwitterDark.png";

interface Props {}

export const Bottom: FC<Props> = () => {
  return (
    <div className="p-8">
      <Grid container justifyContent={"center"}>
        <Hidden mdDown>
          <Grid item md={8} container rowSpacing={2}>
            <Grid item xs={12}>
              <div className="border-b-2">
                <div className="flex items-center mb-5">
                  <img src={Logo} alt="Logo" width={67} />
                  <h1 className="pl-2 font-dosis-bold text-darkBlue text-2xl">
                    OptiListen
                  </h1>
                </div>

                <img
                  src={AppStore}
                  alt="AppStore"
                  width={118}
                  className="cursor-pointer mb-5"
                />
              </div>
              <div className="flex mt-4">
                <img
                  src={Twitter}
                  alt="twitter"
                  width={40}
                  className="mr-4 fill-darkBlue"
                />
                <img src={LinkedIn} alt="twitter" width={40} />
              </div>
            </Grid>
            <Grid item xs={4}>
              <p className="text-gray-500  font-sfpro-regular text-xl cursor-pointer">
                About
              </p>
            </Grid>
            <Grid item xs={4}>
              <p className="text-gray-500  font-sfpro-regular text-xl cursor-pointer">
                Feedback
              </p>
            </Grid>
            <Grid item xs={4}>
              <p className="text-gray-500  font-sfpro-regular text-xl cursor-pointer">
                Privacy
              </p>
            </Grid>
            <Grid item xs={4}>
              <p className="text-gray-500  font-sfpro-regular text-xl cursor-pointer">
                Who We Are
              </p>
            </Grid>
            <Grid item xs={4}>
              <p className="text-gray-500  font-sfpro-regular text-xl cursor-pointer">
                FAQs
              </p>
            </Grid>
            <Grid item xs={4}>
              <p className="text-gray-500  font-sfpro-regular text-xl cursor-pointer">
                Terms of Service
              </p>
            </Grid>

            <Grid item xs={12}>
              <p className="text-gray-300  font-sfpro-regular text-md">
                © Legal Jargon, Copyright © 2022 Long Sky Media. All rights
                reserved.
              </p>
            </Grid>
          </Grid>
        </Hidden>
        <Hidden mdUp>
          <Grid item xs={12} container rowSpacing={2}>
            <Grid item xs={12}>
              <div className="border-b-2">
                <div className="flex items-center mb-5">
                  <img src={Logo} alt="Logo" width={67} />
                  <h1 className="pl-2 font-dosis-bold text-darkBlue text-2xl">
                    OptiListen
                  </h1>
                </div>

                <img
                  src={AppStore}
                  alt="AppStore"
                  width={118}
                  className="cursor-pointer mb-5"
                />
              </div>
              <div className="flex mt-4">
                <img
                  src={Twitter}
                  alt="twitter"
                  width={40}
                  className="mr-4 fill-darkBlue"
                />
                <img src={LinkedIn} alt="twitter" width={40} />
              </div>
            </Grid>
            <Grid item xs={6}>
              <p className="text-gray-500  font-sfpro-regular text-xl cursor-pointer">
                About
              </p>
            </Grid>
            <Grid item xs={6}>
              <p className="text-gray-500  font-sfpro-regular text-xl cursor-pointer">
                Feedback
              </p>
            </Grid>
            <Grid item xs={6}>
              <p className="text-gray-500  font-sfpro-regular text-xl cursor-pointer">
                Privacy
              </p>
            </Grid>
            <Grid item xs={6}>
              <p className="text-gray-500  font-sfpro-regular text-xl cursor-pointer">
                Who We Are
              </p>
            </Grid>
            <Grid item xs={6}>
              <p className="text-gray-500  font-sfpro-regular text-xl cursor-pointer">
                FAQs
              </p>
            </Grid>
            <Grid item xs={6}>
              <p className="text-gray-500  font-sfpro-regular text-xl cursor-pointer">
                Terms of Service
              </p>
            </Grid>

            <Grid item xs={12}>
              <p className="text-gray-300  font-sfpro-regular text-md">
                © Legal Jargon, Copyright © 2022 Long Sky Media. All rights
                reserved.
              </p>
            </Grid>
          </Grid>
        </Hidden>
      </Grid>
    </div>
  );
};
