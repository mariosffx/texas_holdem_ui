import express from "express";
import path from "path";
import { fileURLToPath } from "url";
import dotenv from "dotenv";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Recreate __dirname in ESM
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Absolute path
const webRoot = path.join(__dirname, "build", "web");

// 1) NEVER hard-cache the app shell or SW (prevents "old version" issues)
app.use((req, res, next) => {
  const p = req.path;

  if (
    p === "/" ||
    p === "" ||
    p === "/index.html" ||
    p === "/flutter_service_worker.js" ||
    p === "/version.json" ||
    p === "/manifest.json" ||
    p === "/flutter.js"
  ) {
    res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    res.setHeader("Pragma", "no-cache");
    res.setHeader("Expires", "0");
  }

  next();
});

// 2) Cache static assets aggressively (fine for Flutter build outputs)
app.use(
  express.static(webRoot, {
    // apply caching headers ONLY to real files served by express.static
    etag: true,
    lastModified: true,
    maxAge: "30d",
    immutable: true,
    setHeaders: (res, filePath) => {
      const fileName = path.basename(filePath);

      // Override caching for critical bootstrap files (even if requested as static)
      if (
        fileName === "index.html" ||
        fileName === "flutter_service_worker.js" ||
        fileName === "version.json" ||
        fileName === "manifest.json" ||
        fileName === "flutter.js"
      ) {
        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        res.setHeader("Pragma", "no-cache");
        res.setHeader("Expires", "0");
      }
    }
  })
);

// 3) SPA fallback: all routes -> index.html (with no-cache)
app.get("*", (req, res) => {
  res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
  res.setHeader("Pragma", "no-cache");
  res.setHeader("Expires", "0");
  res.sendFile(path.join(webRoot, "index.html"));
});

app.listen(PORT, () => console.log(`Web on http://localhost:${PORT}`));
