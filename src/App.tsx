import "./App.css";
import { AppRoutes } from "./routes/routes";
import { createTheme, ThemeProvider } from "@mui/material/styles";

function App() {
  const theme = createTheme({
    palette: {
      info: {
        main: "#34A0A4",
      },
    },
  });
  return (
    <ThemeProvider theme={theme}>
      <AppRoutes />
    </ThemeProvider>
  );
}

export default App;
