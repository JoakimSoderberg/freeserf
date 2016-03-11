#
# this module look for SDL2_Mixer (http://www.libsdl.org) support
# it will define the following values
#
# SDLMIXER_INCLUDE_DIR  = where SDL_mixer.h can be found
# SDLMIXER_LIBRARY      = the library to link against SDL2_mixer
# SDLMIXER_FOUND        = set to 1 if SDL2_mixer is found
#
set(SDLMIXER_DIR CACHE PATH "SDL2 mixer root directory")
message("SDLMIXER_DIR = ${SDLMIXER_DIR}")

SET(SDLMIXER_SEARCH_PATHS
  ${SDLMIXER_DIR}
  ~/Library/Frameworks
  /Library/Frameworks
  /usr/local
  /usr
  /sw # Fink
  /opt/local # DarwinPorts
  /opt/csw # Blastwave
  /opt
)

FIND_PATH(SDLMIXER_INCLUDE_DIR SDL_mixer.h
  HINTS
  $ENV{SDLMIXER_DIR}
  $ENV{SDL2DIR}
  PATH_SUFFIXES include/SDL2 include
  PATHS ${SDLMIXER_SEARCH_PATHS}
)

FIND_LIBRARY(SDLMIXER_LIBRARY_TEMP
  NAMES SDL2_mixer
  HINTS
  $ENV{SDLMIXER_DIR}
  $ENV{SDL2DIR}
  PATH_SUFFIXES lib lib/x86 lib64 lib/x64
  PATHS ${SDLMIXER_SEARCH_PATHS}
)

IF(NOT SDLMIXER_BUILDING_LIBRARY)
  IF(NOT ${SDLMIXER_INCLUDE_DIR} MATCHES ".framework")
    # Non-OS X framework versions expect you to also dynamically link to
    # SDL2main. This is mainly for Windows and OS X. Other (Unix) platforms
    # seem to provide SDL2main for compatibility even though they don't
    # necessarily need it.
    FIND_LIBRARY(SDLMIXER_LIBRARY
      NAMES SDL2_mixer
      HINTS
      $ENV{SDL2DIR}
      PATH_SUFFIXES lib lib/x86 lib64 lib/x64 
      PATHS ${SDLMIXER_SEARCH_PATHS}
    )
  ENDIF(NOT ${SDLMIXER_INCLUDE_DIR} MATCHES ".framework")
ENDIF(NOT SDLMIXER_BUILDING_LIBRARY)

IF(SDLMIXER_LIBRARY_TEMP)
  # For OS X, SDL2 uses Cocoa as a backend so it must link to Cocoa.
  # CMake doesn't display the -framework Cocoa string in the UI even
  # though it actually is there if I modify a pre-used variable.
  # I think it has something to do with the CACHE STRING.
  # So I use a temporary variable until the end so I can set the
  # "real" variable in one-shot.
  IF(APPLE)
    SET(SDLMIXER_LIBRARY_TEMP ${SDLMIXER_LIBRARY_TEMP} "-framework Cocoa")
  ENDIF(APPLE)

  # Set the final string here so the GUI reflects the final state.
  SET(SDLMIXER_LIBRARY ${SDLMIXER_LIBRARY_TEMP} CACHE STRING "Where the SDL2 Library can be found")
  # Set the temp variable to INTERNAL so it is not seen in the CMake GUI
  SET(SDLMIXER_LIBRARY_TEMP "${SDLMIXER_LIBRARY_TEMP}" CACHE INTERNAL "")
ENDIF(SDLMIXER_LIBRARY_TEMP)

INCLUDE(FindPackageHandleStandardArgs)

if (NOT SDL2_mixer-NOTFOUND)
  set(SDLMIXER_FOUND 1)
endif()

MARK_AS_ADVANCED(
  SDLMIXER_INCLUDE_DIR 
  SDLMIXER_LIBRARY
)
