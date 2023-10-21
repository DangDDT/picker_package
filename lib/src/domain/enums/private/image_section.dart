enum MediaSection {
  noStoragePermission, // Permission denied, but not forever
  noStoragePermissionPermanent, // Permission denied forever
  browseFiles, // The UI shows the button to pick files
  imageLoaded, // File picked and shown in the screen
}
