import * as React from "react";
import { Bottom } from "../components/Bottom";
import { Drawer } from "../components/Drawer";

import { Header } from "../components/Header";

interface Props {
  children: React.ReactNode;
}

export const BaseLayout: React.FC<Props> = ({ children }) => {
  const [drawerOpened, setDrawerOpen] = React.useState(false);

  const toggleDrawer = (open: boolean) => {
    setDrawerOpen(open);
  };

  return (
    <div>
      <Header toggleDrawer={toggleDrawer} />
      <Drawer drawerOpened={drawerOpened} toggleDrawer={toggleDrawer} />
      {children}
      <Bottom />
    </div>
  );
};
