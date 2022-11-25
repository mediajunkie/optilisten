import { FC } from "react";
import { BaseLayout } from "./BaseLayout";

import Fireworks from "../assets/images/Fireworks.png";
import LinkedIn from "../assets/images/LinkedIn.png";
import Twitter from "../assets/images/Twitter.png";
import { Grid, Hidden } from "@mui/material";
import Accordion from "@mui/material/Accordion";
import AccordionSummary from "@mui/material/AccordionSummary";
import AccordionDetails from "@mui/material/AccordionDetails";
import Typography from "@mui/material/Typography";
import ExpandMoreIcon from "@mui/icons-material/ExpandMore";

export const AboutPage: FC = () => {
  return (
    <BaseLayout>
      <div>
        <Grid container justifyContent={"center"} className="bg-darkBlue p-10  h-[400px]">
          <Grid item md={8} container>
            <Hidden mdDown>
              <Grid item xs={6}>
                <p className="text-white font-sfpro-bold text-3xl pb-6">
                  About OptiListen
                </p>
                <p className="text-white font-sfpro-regular text-xl">
                  OptiListen helps you get better at listening. Quickly set
                  goals and track how much time you’re speaking on video and
                  audio calls. Unlock the listener within.{" "}
                </p>
                <div className="flex mt-4">
                  <img
                    src={Twitter}
                    alt="twitter"
                    width={40}
                    className="mr-4"
                  />
                  <img src={LinkedIn} alt="twitter" width={40} />
                </div>
              </Grid>
            </Hidden>
            <Hidden mdUp>
              <Grid item xs={12}>
                <div className="relative h-[270px]">
                  <div className="flex justify-center absolute left-0 top-0 z-10">
                    <img
                      src={Fireworks}
                      alt="fireworks"
                      className="w-3/4 z-10"
                    />
                  </div>
                  <div className="z-20 relative">
                    <p className="text-white font-sfpro-bold text-3xl pb-6">
                      About OptiListen
                    </p>
                    <p className="text-white font-sfpro-regular text-xl">
                      OptiListen helps you get better at listening. Quickly set
                      goals and track how much time you’re speaking on video and
                      audio calls. Unlock the listener within.{" "}
                    </p>
                    <div className="flex mt-4">
                      <img
                        src={Twitter}
                        alt="twitter"
                        width={40}
                        className="mr-4"
                      />
                      <img src={LinkedIn} alt="twitter" width={40} />
                    </div>
                  </div>
                </div>
              </Grid>
            </Hidden>
            <Hidden mdDown>
              <Grid item xs={6}>
                <div className="flex justify-center">
                  <img src={Fireworks} alt="fireworks" className="w-3/4" />
                </div>
              </Grid>
            </Hidden>
          </Grid>
        </Grid>

        <Grid container justifyContent={"center"} className="p-10 mt-10">
          <Grid item md={8} container>
            <p className="text-darkBlue font-sfpro-bold text-3xl pb-6">
              Who We Are
            </p>
            <p className="text-black font-sfpro-regular text-xl pb-6">
              Long Sky Media publishes books, makes apps, and tries to bring a
              wee bit of trout music to the world. OptiListen was created by Dan
              Brodnitz and Christian Crumlish, who also fancy themselves its
              first customers. The app was designed by Elaine Phong and
              developed by Fractal Labs. The website was designed by Josh
              Eisenstat. Rebecca Baror provided design direction.
            </p>
          </Grid>
        </Grid>

        <Grid container justifyContent={"center"} className="p-10">
          <Grid item md={8} container>
            <p className="text-darkBlue font-sfpro-bold text-3xl pb-6">
              Questions you may have
            </p>
            <Accordion>
              <AccordionSummary
                expandIcon={<ExpandMoreIcon />}
                aria-controls="panel1a-content"
                id="panel1a-header"
              >
                <p className="text-black font-sfpro-regular text-xl">
                  Why did you all make this app?
                </p>
              </AccordionSummary>
              <AccordionDetails>
                <Typography>
                  We were working on our own listening skills, and realized that
                  talk talk was going to break our spirits, so we created a
                  hands-free app that could let us focus less on the buttons and
                  more on trying to be a little more present for the people on
                  our audio and video calls.
                </Typography>
              </AccordionDetails>
            </Accordion>
            <Accordion>
              <AccordionSummary
                expandIcon={<ExpandMoreIcon />}
                aria-controls="panel1a-content"
                id="panel1a-header"
              >
                <p className="text-black font-sfpro-regular text-xl">
                  Do I need to wear headphones for the app to work?
                </p>
              </AccordionSummary>
              <AccordionDetails>
                <Typography>
                  We were working on our own listening skills, and realized that
                  talk talk was going to break our spirits, so we created a
                  hands-free app that could let us focus less on the buttons and
                  more on trying to be a little more present for the people on
                  our audio and video calls.
                </Typography>
              </AccordionDetails>
            </Accordion>
            <Accordion>
              <AccordionSummary
                expandIcon={<ExpandMoreIcon />}
                aria-controls="panel1a-content"
                id="panel1a-header"
              >
                <p className="text-black font-sfpro-regular text-xl">
                  Does the app collect any personal data?
                </p>
              </AccordionSummary>
              <AccordionDetails>
                <Typography>
                  We were working on our own listening skills, and realized that
                  talk talk was going to break our spirits, so we created a
                  hands-free app that could let us focus less on the buttons and
                  more on trying to be a little more present for the people on
                  our audio and video calls.
                </Typography>
              </AccordionDetails>
            </Accordion>
            <Accordion>
              <AccordionSummary
                expandIcon={<ExpandMoreIcon />}
                aria-controls="panel1a-content"
                id="panel1a-header"
              >
                <p className="text-black font-sfpro-regular text-xl">
                  Are you all better listeners now?
                </p>
              </AccordionSummary>
              <AccordionDetails>
                <Typography>
                  We were working on our own listening skills, and realized that
                  talk talk was going to break our spirits, so we created a
                  hands-free app that could let us focus less on the buttons and
                  more on trying to be a little more present for the people on
                  our audio and video calls.
                </Typography>
              </AccordionDetails>
            </Accordion>
          </Grid>
        </Grid>
      </div>
    </BaseLayout>
  );
};
