

/* Define to 1 if you have the <byteswap.h> header file. */
#cmakedefine HAVE_BYTESWAP_H

/* Define to 1 if you have the <endian.h> header file. */
#cmakedefine HAVE_ENDIAN_H

/* Define to 1 if you have the <stdint.h> header file. */
#ifndef HAVE_STDINT_H
#cmakedefine HAVE_STDINT_H
#endif

/* Define to 1 if you have the <sys/endian.h> header file. */
#cmakedefine HAVE_SYS_ENDIAN_H

/* Define to 1 if you have the <unistd.h> header file. */
#cmakedefine HAVE_UNISTD_H

/* Define WORDS_BIGENDIAN to 1 if your processor stores words with the most
   significant byte first (like Motorola and SPARC, unlike Intel). */
#ifdef APPLE_UNIVERSAL_BUILD
# ifdef __BIG_ENDIAN__
#  define WORDS_BIGENDIAN 1
# endif
#else
# ifndef WORDS_BIGENDIAN
#  undef WORDS_BIGENDIAN
# endif
#endif

/* Enable large inode numbers on Mac OS X 10.5.  */
#ifndef _DARWIN_USE_64_BIT_INODE
# define _DARWIN_USE_64_BIT_INODE 1
#endif

#if !defined(_STDINT_H_) && (!defined(HAVE_STDINT_H) || !_HAVE_STDINT_H)
#if defined(_MSC_VER)
typedef signed __int8 int8_t;
typedef unsigned __int8 uint8_t;
typedef signed __int16 int16_t;
typedef unsigned __int16 uint16_t;
typedef signed __int32 int32_t;
typedef unsigned __int32 uint32_t;
typedef signed __int64 int64_t;
typedef unsigned __int64 uint64_t;
#ifndef _UINTPTR_T_DEFINED
# ifdef  _WIN64
typedef unsigned __int64 uintptr_t;
# else
typedef unsigned int uintptr_t;
# endif
#define _UINTPTR_T_DEFINED
#endif // _UINTPTR_T_DEFINED
#endif
#endif
#if 0
/* Define to the type of a signed integer type of width exactly 8 bits if such
   a type exists and the standard includes do not define it. */
#ifndef HAVE_INT8_T
# define HAVE_INT8_T
# define int8_t ${FREESERF_INT8}
#endif

/* Define to the type of a signed integer type of width exactly 16 bits if
   such a type exists and the standard includes do not define it. */
#ifndef HAVE_INT16_T
# define HAVE_INT16_T
# define int16_t ${FREESERF_INT16}
#endif

/* Define to the type of a signed integer type of width exactly 32 bits if
   such a type exists and the standard includes do not define it. */
#ifndef HAVE_INT32_T
# define HAVE_INT32_T
# define int32_t ${FREESERF_INT32}
#endif

/* Define to the type of a signed integer type of width exactly 64 bits if
   such a type exists and the standard includes do not define it. */
#ifndef HAVE_INT64_T
# define HAVE_INT64_T
# define int64_t ${FREESERF_INT64}
#endif

/* Define to the type of an unsigned integer type of width exactly 8 bits if
   such a type exists and the standard includes do not define it. */
#ifndef HAVE_UINT8_T
# define HAVE_UINT8_T
# define uint8_t ${FREESERF_UINT8}
#endif

/* Define to the type of an unsigned integer type of width exactly 16 bits if
   such a type exists and the standard includes do not define it. */
#ifndef HAVE_UINT16_T
# define HAVE_UINT16_T
# define uint16_t ${FREESERF_UINT16}
#endif

/* Define to the type of an unsigned integer type of width exactly 32 bits if
   such a type exists and the standard includes do not define it. */
#ifndef HAVE_UINT32_T
# define HAVE_UINT32_T
# define uint32_t ${FREESERF_UINT32}
#endif

/* Define to the type of an unsigned integer type of width exactly 64 bits if
   such a type exists and the standard includes do not define it. */
#ifndef HAVE_UINT64_T
# define HAVE_UINT64_T
# define uint64_t ${FREESERF_UINT64}
#endif
#endif

/* Windows snprintf is not C99 compatible */
#ifdef WIN32
#include "windows/win_snprintf.h"
#endif
