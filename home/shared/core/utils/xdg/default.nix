{
  config,
  pkgs,
  ...
}: let
  audioPlayer = ["termusic"];
  browser = ["google-chrome-stable"];
  fileManager = ["yazi"];
  imageViewer = ["viewnior"];
  pdfViewer = ["org.pwmt.zathura-pdf-mupdf"];
  textEditor = ["nvim"];
  videoPlayer = ["mpv"];

  xdgAssociations = type: program: list:
    builtins.listToAttrs (map (extension: {
        name = "${type}/${extension}";
        value = program;
      })
      list);

  image = xdgAssociations "image" imageViewer ["gif" "jpeg" "heif" "png" "svg" "webp"];
  video = xdgAssociations "video" videoPlayer ["avi" "mkv" "mp4" "mov" "wmv"];
  audio = xdgAssociations "audio" audioPlayer ["mp3" "flac" "wav" "aac"];
  browserTypes =
    (xdgAssociations "application" browser [
      "json"
      "x-extension-htm"
      "x-extension-html"
      "x-extension-shtml"
      "x-extension-xht"
      "x-extension-xhtml"
    ])
    // (xdgAssociations "x-scheme-handler" browser [
      "about"
      "ftp"
      "http"
      "https"
      "unknown"
    ]);

  # XDG MIME types
  associations = builtins.mapAttrs (_: v: (map (e: "${e}.desktop") v)) ({
      "application/pdf" = pdfViewer;
      "text/html" = browser;
      "text/plain" = textEditor;
      "x-scheme-handler/chrome" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/unknown" = browser;
      "inode/directory" = fileManager;
    }
    // image
    // video
    // audio
    // browserTypes);
in {
  home.packages = with pkgs; [xdg-utils];

  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };

    userDirs = {
      enable = true;

      createDirectories = true;

      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      publicShare = "${config.home.homeDirectory}/public";
      templates = "${config.home.homeDirectory}/templates";
      videos = "${config.home.homeDirectory}/videos";

      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/screenshots";
      };
    };
  };
}
