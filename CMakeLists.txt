cmake_minimum_required(VERSION 2.8)
project(freeserf)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)


set(FREESERF_NAME freeserf CACHE STRING "Name of the executable")

option(ENABLE_SDL2_MIXER "Use SDL2 mixer for sound if available" ON)

if (APPLE)
	option(APPLE_UNIVERSAL_BUILD "Build OSX universal binary" OFF)
endif()

#
# Regenerate version-vcs.h on each build to get up to date git version.
#

# Generate a cmake script that runs on each build, that will get the git version.
configure_file("${PROJECT_SOURCE_DIR}/cmake/configure_version_vcs.cmake.in"
  "${PROJECT_BINARY_DIR}/configure_version_vcs.cmake" @ONLY)

# Run the generated script to output the header.
add_custom_command(OUTPUT ${PROJECT_BINARY_DIR}/version-vcs.h
  COMMAND ${CMAKE_COMMAND} -P
    ${PROJECT_BINARY_DIR}/configure_version_vcs.cmake
  DEPENDS
    ${PROJECT_BINARY_DIR}/configure_version_vcs.cmake
    ${PROJECT_SOURCE_DIR}/cmake/version-vcs.h.in
  COMMENT "Configuring version-vcs.h"
  VERBATIM)

# Depend on the header, this will trigger the above command. For all build targets. 
add_custom_target(configure_version_vcs ALL
  DEPENDS ${PROJECT_BINARY_DIR}/version-vcs.h)



include(FindStdIntTypes)

include_directories("${PROJECT_SOURCE_DIR}" "${PROJECT_BINARY_DIR}")

set(SRCS
	src/audio.cc
	src/building.c
	src/data-source-dos.cc
	src/data-source.cc
	src/data.cc
	src/event_loop-sdl.cc
	src/event_loop.cc
	src/flag.c
	src/freeserf.cc
	src/game-init.cc
	src/game.c
	src/gfx.cc
	src/gui.cc
	src/interface.cc
	src/list.c
	src/log.c
	src/map.c
	src/minimap.cc
	src/mission.c
	src/notification.cc
	src/panel.cc
	src/pathfinder.cc
	src/player.c
	src/popup.cc
	src/random.c
	src/savegame.c
	src/serf.c
	src/sfx2wav.cc
	src/tpwm.cc
	src/version.c
	src/video-sdl.cc
	src/video.cc
	src/viewport.cc
	src/xmi2mid.cc)

set(HDRS
	src/audio.h
	src/building.h
	src/data-source-dos.h
	src/data-source.h
	src/data.h
	src/debug.h
	src/event_loop-sdl.h
	src/event_loop.h
	src/flag.h
	src/freeserf.h
	src/freeserf_endian.h
	src/game-init.h
	src/game.h
	src/gfx.h
	src/gui.h
	src/interface.h
	src/list.h
	src/log.h
	src/map.h
	src/minimap.h
	src/misc.h
	src/mission.h
	src/notification.h
	src/panel.h
	src/pathfinder.h
	src/player.h
	src/popup.h
	src/random.h
	src/resource.h
	src/savegame.h
	src/serf.h
	src/sfx2wav.h
	src/tpwm.h
	src/version.h
	src/video-sdl.h
	src/video.h
	src/viewport.h
	src/xmi2mid.h)

if (WIN32)
	list(APPEND HDRS windows/win_snprintf.h)
	set_source_files_properties(${SRCS} ${HDRS} PROPERTIES LANGUAGE CXX)
endif()

find_package(SDL2 REQUIRED)
message("SDL2_LIBRARY = ${SDL2_LIBRARY}")

if (ENABLE_SDL2_MIXER)
	find_package(SDL2_mixer)
endif()

if (SDLMIXER_FOUND)
	message("SDL2 mixer found ${SDLMIXER_LIBRARY}")
	list(APPEND SRCS src/audio-sdlmixer.cc)
	list(APPEND HDRS src/audio-sdlmixer.h)
	include_directories(${SDLMIXER_INCLUDE_DIR})
else()
	message("SDL2 mixer not found")
	list(APPEND SRCS src/audio-dummy.cc)
	list(APPEND HDRS src/audio-dummy.h)
endif()

include_directories(${SDL2_INCLUDE_DIR})

add_definitions(-DHAVE_CONFIG_H)
configure_file("${PROJECT_SOURCE_DIR}/config.h.cmake" "${PROJECT_BINARY_DIR}/config.h")

source_group("Source files" FILES ${SRCS})
source_group("Header files" FILES ${HDRS})

add_executable(${FREESERF_NAME} ${SRCS} ${HDRS})
target_link_libraries(${FREESERF_NAME} ${SDL2_LIBRARY})

if (SDLMIXER_FOUND)
	target_link_libraries(${FREESERF_NAME} ${SDLMIXER_LIBRARY})
endif()


if (MSVC)
	set_target_properties(${FREESERF_NAME} 
		PROPERTIES LINK_FLAGS " /INCREMENTAL /SUBSYSTEM:WINDOWS /DYNAMICBASE:NO /NODEFAULTLIB:msvcrt.lib /NODEFAULTLIB:msvcrtd.lib") #/NODEFAULTLIB:\"msvcrtd.lib\"")
	#	"/NODEFAULTLIB:\"msvcrt.lib\" /NODEFAULTLIB:\"msvcrtd.lib\"")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd\"4290\"")
endif()
