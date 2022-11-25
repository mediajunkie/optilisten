import Box from "@mui/material/Box";
import List from "@mui/material/List";
import ListItem from "@mui/material/ListItem";
import ListItemButton from "@mui/material/ListItemButton";
import ListItemIcon from "@mui/material/ListItemIcon";
import ListItemText from "@mui/material/ListItemText";
import InfoIcon from "@mui/icons-material/Info";
import FeedbackIcon from "@mui/icons-material/Feedback";
import PolicyIcon from "@mui/icons-material/Policy";
import SwipeableDrawer from "@mui/material/SwipeableDrawer";
import LiveHelpIcon from "@mui/icons-material/LiveHelp";
import GavelIcon from "@mui/icons-material/Gavel";
import EmojiPeopleIcon from "@mui/icons-material/EmojiPeople";
import { FC } from "react";

import Logo from "../assets/images/logo.png";

const Icons = [
  <InfoIcon />,
  <FeedbackIcon />,
  <PolicyIcon />,
  <EmojiPeopleIcon />,
  <LiveHelpIcon />,
  <GavelIcon />,
];
const Options = [
  "About",
  "Feedback",
  "Privacy",
  "Who We Are",
  "FAQs",
  "Terms of Service",
];

interface Props {
  drawerOpened: boolean;
  toggleDrawer: (val: boolean) => void;
}
export const Drawer: FC<Props> = ({ drawerOpened, toggleDrawer }) => {
  const Menus = () => {
    return (
      <Box
        sx={{ width: 250, paddingTop: 4 }}
        role="presentation"
        onClick={() => toggleDrawer(false)}
        onKeyDown={() => toggleDrawer(false)}
      >
        <div className="flex justify-center pb-4">
          <img src={Logo} alt="Logo" width={67} />
        </div>
        <List>
          {Options.map((text, index) => (
            <ListItem key={text} disablePadding>
              <ListItemButton>
                <ListItemIcon>
                  <ListItemIcon>{Icons[index]}</ListItemIcon>
                </ListItemIcon>
                <ListItemText primary={text} />
              </ListItemButton>
            </ListItem>
          ))}
        </List>
      </Box>
    );
  };

  return (
    <SwipeableDrawer
      anchor={"left"}
      open={drawerOpened}
      onClose={() => toggleDrawer(false)}
      onOpen={() => toggleDrawer(true)}
    >
      {Menus()}
    </SwipeableDrawer>
  );
};
