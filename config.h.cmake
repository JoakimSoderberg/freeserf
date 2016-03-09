

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

/* Define to the type of a signed integer type of width exactly 16 bits if
   such a type exists and the standard includes do not define it. */

#ifndef HAVE_INT16_T
# define int16_t ${FREESERF_INT16}
#endif

/* Define to the type of a signed integer type of width exactly 32 bits if
   such a type exists and the standard includes do not define it. */
#ifndef HAVE_INT32_T
# define int32_t ${FREESERF_INT32}
#endif

/* Define to the type of a signed integer type of width exactly 8 bits if such
   a type exists and the standard includes do not define it. */
#ifndef HAVE_INT8_T
# define int8_t ${FREESERF_INT8}
#endif

/* Define to the type of an unsigned integer type of width exactly 16 bits if
   such a type exists and the standard includes do not define it. */
#ifndef HAVE_UINT16_T
# define uint16_t ${FREESERF_UINT16}
#endif

/* Define to the type of an unsigned integer type of width exactly 32 bits if
   such a type exists and the standard includes do not define it. */
#ifndef HAVE_UINT32_T
# define uint32_t ${FREESERF_UINT32}
#endif

/* Define to the type of an unsigned integer type of width exactly 8 bits if
   such a type exists and the standard includes do not define it. */
#ifndef HAVE_UINT8_T
# define uint8_t ${FREESERF_UINT8}
#endif
