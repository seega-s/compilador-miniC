/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output, and Bison version.  */
#define YYBISON 30802

/* Bison version string.  */
#define YYBISON_VERSION "3.8.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "sintaxis.y"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "listaSimbolos.h"
#include "listaCodigo.h"

extern char *yytext;
extern int yylineno;

#define N_TEMP 10
// las variables globales a usar
int tmp[N_TEMP] = {0}; 
Lista tablaSimb;
Tipo tipo;
int contEtiquetas = 0;
int contCadenas = 0;

// las funciones a usar
void inicializaTemporales();
void liberaTemporal(char * registro);
int nuevoTemp();
char* nuevaEtiq();

void imprimirTablaS();
void imprimeLC(ListaC codigo);
bool perteneceTablaS(char *nombre);
void anadeEntrada(char *nombre, Tipo t, int v);
bool esConstante(char *nombre);
Operacion operSaltoCond(char *op, char *exp, char *etiq);
Operacion operEtiq(char *etiq);
Operacion crearOpArit(char *op, char *oper1, char *oper2, char tempStr[5]);
void siguienteRegistro(char *registro);

int yylex(); // en semBison dice que tiene que ser declarado
void yyerror(char *s);


#line 110 "sintaxis.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

#include "sintaxis.tab.h"
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_STRING = 3,                     /* STRING  */
  YYSYMBOL_ID = 4,                         /* ID  */
  YYSYMBOL_ENTERO = 5,                     /* ENTERO  */
  YYSYMBOL_VAR = 6,                        /* VAR  */
  YYSYMBOL_CONST = 7,                      /* CONST  */
  YYSYMBOL_INT = 8,                        /* INT  */
  YYSYMBOL_IF = 9,                         /* IF  */
  YYSYMBOL_ELSE = 10,                      /* ELSE  */
  YYSYMBOL_WHILE = 11,                     /* WHILE  */
  YYSYMBOL_PRINT = 12,                     /* PRINT  */
  YYSYMBOL_READ = 13,                      /* READ  */
  YYSYMBOL_DOTCOMMA = 14,                  /* DOTCOMMA  */
  YYSYMBOL_COMMA = 15,                     /* COMMA  */
  YYSYMBOL_PLUSOP = 16,                    /* PLUSOP  */
  YYSYMBOL_MINUSOP = 17,                   /* MINUSOP  */
  YYSYMBOL_MULTOP = 18,                    /* MULTOP  */
  YYSYMBOL_DIVOP = 19,                     /* DIVOP  */
  YYSYMBOL_LPAREN = 20,                    /* LPAREN  */
  YYSYMBOL_RPAREN = 21,                    /* RPAREN  */
  YYSYMBOL_LBRACE = 22,                    /* LBRACE  */
  YYSYMBOL_RBRACE = 23,                    /* RBRACE  */
  YYSYMBOL_QMARK = 24,                     /* QMARK  */
  YYSYMBOL_COLON = 25,                     /* COLON  */
  YYSYMBOL_ASIGN = 26,                     /* ASIGN  */
  YYSYMBOL_MINUSOP_UN = 27,                /* MINUSOP_UN  */
  YYSYMBOL_YYACCEPT = 28,                  /* $accept  */
  YYSYMBOL_program = 29,                   /* program  */
  YYSYMBOL_30_1 = 30,                      /* $@1  */
  YYSYMBOL_declarations = 31,              /* declarations  */
  YYSYMBOL_tipo = 32,                      /* tipo  */
  YYSYMBOL_var_list = 33,                  /* var_list  */
  YYSYMBOL_const_list = 34,                /* const_list  */
  YYSYMBOL_statement_list = 35,            /* statement_list  */
  YYSYMBOL_statement = 36,                 /* statement  */
  YYSYMBOL_print_list = 37,                /* print_list  */
  YYSYMBOL_print_item = 38,                /* print_item  */
  YYSYMBOL_read_list = 39,                 /* read_list  */
  YYSYMBOL_expression = 40                 /* expression  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;




#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

/* Work around bug in HP-UX 11.23, which defines these macros
   incorrectly for preprocessor constants.  This workaround can likely
   be removed in 2023, as HPE has promised support for HP-UX 11.23
   (aka HP-UX 11i v2) only through the end of 2022; see Table 2 of
   <https://h20195.www2.hpe.com/V2/getpdf.aspx/4AA4-7673ENW.pdf>.  */
#ifdef __hpux
# undef UINT_LEAST8_MAX
# undef UINT_LEAST16_MAX
# define UINT_LEAST8_MAX 255
# define UINT_LEAST16_MAX 65535
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_int8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if !defined yyoverflow

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* !defined yyoverflow */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   116

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  28
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  13
/* YYNRULES -- Number of rules.  */
#define YYNRULES  35
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  88

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   282


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27
};

#if YYDEBUG
/* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,    52,    52,    52,    63,    66,    71,    76,    81,    89,
      99,   123,   152,   157,   162,   188,   191,   230,   245,   280,
     285,   291,   294,   300,   331,   373,   413,   456,   468,   481,
     494,   506,   574,   583,   586,   607
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if YYDEBUG || 0
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end of file\"", "error", "\"invalid token\"", "STRING", "ID",
  "ENTERO", "VAR", "CONST", "INT", "IF", "ELSE", "WHILE", "PRINT", "READ",
  "DOTCOMMA", "COMMA", "PLUSOP", "MINUSOP", "MULTOP", "DIVOP", "LPAREN",
  "RPAREN", "LBRACE", "RBRACE", "QMARK", "COLON", "ASIGN", "MINUSOP_UN",
  "$accept", "program", "$@1", "declarations", "tipo", "var_list",
  "const_list", "statement_list", "statement", "print_list", "print_item",
  "read_list", "expression", YY_NULLPTR
};

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  return yytname[yysymbol];
}
#endif

#define YYPACT_NINF (-60)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
static const yytype_int8 yypact[] =
{
     -60,     7,     5,   -60,    -4,    15,    18,   -60,    20,    34,
      34,     6,   -60,    40,    65,    25,    50,    54,    62,    86,
     -60,   -60,   -60,   -60,    32,    67,    47,    51,    51,    51,
      55,    76,    26,   -60,    95,    51,   -60,   101,   -60,   -60,
      51,    51,    69,     4,    73,   -60,   -10,   -60,    85,   -60,
      -9,   -60,   -60,    85,    81,   -60,    60,   -60,    51,    51,
      51,    51,    41,    41,    55,    94,   105,    96,    51,   -60,
      51,   -60,   -60,   -60,   -60,   102,   -60,   -60,   -60,   -60,
     -60,    85,    48,    41,    51,   -60,    79,   -60
};

/* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE does not specify something else to do.  Zero
   means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       2,     0,     0,     1,     0,     0,     0,     6,    13,     0,
       0,     0,     7,     0,     0,     0,     0,     0,     0,     0,
      13,     3,    12,     8,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     4,     0,     0,     5,     0,    34,    35,
       0,     0,     0,     0,     0,    24,     0,    21,    23,    25,
       0,    15,     9,    10,     0,    32,     0,    14,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,    33,
       0,    27,    28,    29,    30,    17,    18,    22,    19,    26,
      20,    11,     0,     0,     0,    16,     0,    31
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -60,   -60,   -60,   -60,   103,   -60,   -60,    91,   -59,   -60,
      52,   -60,   -27
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
       0,     1,     2,     8,    13,    24,    26,    11,    22,    46,
      47,    50,    48
};

/* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule whose
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int8 yytable[] =
{
      42,    43,    44,    75,    76,    64,    66,     3,    53,     4,
      15,    65,    67,    55,    56,    16,     5,    17,    18,    19,
      58,    59,    60,    61,    85,    62,     9,    10,    20,    21,
      15,    71,    72,    73,    74,    16,     6,    17,    18,    19,
       7,    81,    12,    82,    23,    15,    33,    34,    20,    51,
      16,    27,    17,    18,    19,    38,    39,    86,    45,    38,
      39,    36,    37,    20,    58,    59,    60,    61,    40,    25,
      28,    41,    40,    84,    29,    41,    58,    59,    60,    61,
      49,    69,    30,    57,    70,    58,    59,    60,    61,    58,
      59,    60,    61,    35,    63,    58,    59,    60,    61,    52,
      87,    58,    59,    60,    61,    54,    31,    68,    78,    79,
      80,    32,    83,    14,     0,     0,    77
};

static const yytype_int8 yycheck[] =
{
      27,    28,    29,    62,    63,    15,    15,     0,    35,     4,
       4,    21,    21,    40,    41,     9,    20,    11,    12,    13,
      16,    17,    18,    19,    83,    21,     6,     7,    22,    23,
       4,    58,    59,    60,    61,     9,    21,    11,    12,    13,
      22,    68,     8,    70,     4,     4,    14,    15,    22,    23,
       9,    26,    11,    12,    13,     4,     5,    84,     3,     4,
       5,    14,    15,    22,    16,    17,    18,    19,    17,     4,
      20,    20,    17,    25,    20,    20,    16,    17,    18,    19,
       4,    21,    20,    14,    24,    16,    17,    18,    19,    16,
      17,    18,    19,    26,    21,    16,    17,    18,    19,     4,
      21,    16,    17,    18,    19,     4,    20,    26,    14,     4,
      14,    20,    10,    10,    -1,    -1,    64
};

/* YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
   state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,    29,    30,     0,     4,    20,    21,    22,    31,     6,
       7,    35,     8,    32,    32,     4,     9,    11,    12,    13,
      22,    23,    36,     4,    33,     4,    34,    26,    20,    20,
      20,    20,    35,    14,    15,    26,    14,    15,     4,     5,
      17,    20,    40,    40,    40,     3,    37,    38,    40,     4,
      39,    23,     4,    40,     4,    40,    40,    14,    16,    17,
      18,    19,    21,    21,    15,    21,    15,    21,    26,    21,
      24,    40,    40,    40,    40,    36,    36,    38,    14,     4,
      14,    40,    40,    10,    25,    36,    40,    21
};

/* YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr1[] =
{
       0,    28,    30,    29,    31,    31,    31,    32,    33,    33,
      34,    34,    35,    35,    36,    36,    36,    36,    36,    36,
      36,    37,    37,    38,    38,    39,    39,    40,    40,    40,
      40,    40,    40,    40,    40,    40
};

/* YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     0,     8,     5,     5,     0,     1,     1,     3,
       3,     5,     2,     0,     4,     3,     7,     5,     5,     5,
       5,     1,     3,     1,     1,     1,     3,     3,     3,     3,
       3,     7,     2,     3,     1,     1
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYNOMEM         goto yyexhaustedlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)




# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YY_USE (yyoutput);
  if (!yyvaluep)
    return;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp,
                 int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)]);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif






/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep)
{
  YY_USE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* Lookahead token kind.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;




/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY; /* Cause a token to be read.  */

  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    YYNOMEM;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        YYNOMEM;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          YYNOMEM;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */


  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      goto yyerrlab1;
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2: /* $@1: %empty  */
#line 52 "sintaxis.y"
              {tablaSimb = creaLS();}
#line 1188 "sintaxis.tab.c"
    break;

  case 3: /* program: $@1 ID LPAREN RPAREN LBRACE declarations statement_list RBRACE  */
#line 52 "sintaxis.y"
                                                                                                 {  ListaC codigo = creaLC(); 
                                                                                                    concatenaLC(codigo, (yyvsp[-2].codigo));
                                                                                                    concatenaLC(codigo, (yyvsp[-1].codigo));
                                                                                                    liberaLC((yyvsp[-2].codigo));
                                                                                                    liberaLC((yyvsp[-1].codigo));
                                                                                                    imprimirTablaS();
                                                                                                    imprimeLC(codigo);
                                                                                                    liberaLS(tablaSimb);
                                                                                                    liberaLC(codigo); 
                                                                                                }
#line 1203 "sintaxis.tab.c"
    break;

  case 4: /* declarations: declarations VAR tipo var_list DOTCOMMA  */
#line 63 "sintaxis.y"
                                                            {   
                                                                (yyval.codigo) = (yyvsp[-4].codigo);                                                    
                                                            }
#line 1211 "sintaxis.tab.c"
    break;

  case 5: /* declarations: declarations CONST tipo const_list DOTCOMMA  */
#line 66 "sintaxis.y"
                                                                {   
                                                                (yyval.codigo) = (yyvsp[-4].codigo);
                                                                concatenaLC((yyval.codigo), (yyvsp[-1].codigo));
                                                                //liberaLC($4);
                                                            }
#line 1221 "sintaxis.tab.c"
    break;

  case 6: /* declarations: %empty  */
#line 71 "sintaxis.y"
                                                                {
                                                                (yyval.codigo) = creaLC();
                                                            }
#line 1229 "sintaxis.tab.c"
    break;

  case 8: /* var_list: ID  */
#line 81 "sintaxis.y"
                                            {  
                                                if(!perteneceTablaS((yyvsp[0].lexema)))
                                                    anadeEntrada((yyvsp[0].lexema), VARIABLE, 0);
                                                else {
                                                    printf("Error semántico: Variable ya declarada '%s' (linea: %d)\n", (yyvsp[0].lexema), yylineno);
                                                    YYERROR; // en semBison pone que hay que abortar así
                                                }
                                            }
#line 1242 "sintaxis.tab.c"
    break;

  case 9: /* var_list: var_list COMMA ID  */
#line 89 "sintaxis.y"
                                                {   
                                                if (!perteneceTablaS((yyvsp[0].lexema)))
                                                    anadeEntrada((yyvsp[0].lexema), VARIABLE, 0);
                                                else {
                                                    printf("Error semántico: Variable ya declarada '%s' (linea: %d)\n", (yyvsp[-2].codigo), yylineno);
                                                    YYERROR; // en semBison pone que hay que abortar así
                                                }
                                            }
#line 1255 "sintaxis.tab.c"
    break;

  case 10: /* const_list: ID ASIGN expression  */
#line 99 "sintaxis.y"
                                            {   
                                                if (!perteneceTablaS((yyvsp[-2].lexema))){
                                                    anadeEntrada((yyvsp[-2].lexema), CONSTANTE, 0);
                                                    ListaC codigo = (yyvsp[0].codigo);

                                                    char nomVar[20];
                                                    sprintf(nomVar, "_%s", (yyvsp[-2].lexema));
                                                    Operacion op = {
                                                        .op = "sw",
                                                        .res = recuperaResLC(codigo),
                                                        .arg1 = strdup(nomVar),
                                                        .arg2 = NULL
                                                    };
                                                    insertaLC(codigo, finalLC(codigo), op);

                                                    inicializaTemporales();
                                                    (yyval.codigo) = codigo;
                                                    
                                                }
                                                else {
                                                    printf("Error semántico: Variable ya declarada '%s' (linea: %d)\n", (yyvsp[-2].lexema), yylineno);
                                                    YYERROR; // en semBison pone que hay que abortar así
                                                }
                                            }
#line 1284 "sintaxis.tab.c"
    break;

  case 11: /* const_list: const_list COMMA ID ASIGN expression  */
#line 123 "sintaxis.y"
                                                        { 
                                                        if (!perteneceTablaS((yyvsp[-2].lexema))){
                                                            anadeEntrada((yyvsp[-2].lexema), CONSTANTE, 0);
                                                            ListaC codigo = (yyvsp[-4].codigo);
                                                            
                                                            concatenaLC(codigo, (yyvsp[0].codigo));
                                                            

                                                            char nombreVar[20];
                                                            sprintf(nombreVar, "_%s", (yyvsp[-2].lexema));
                                                            Operacion op = {
                                                                .op = "sw",
                                                                .res = recuperaResLC((yyvsp[0].codigo)),
                                                                .arg1 = strdup(nombreVar),
                                                                .arg2 = NULL,
                                                            };
                                                            insertaLC(codigo, finalLC(codigo), op);
                                                            inicializaTemporales();
                                                            (yyval.codigo) = codigo;
                                                            
                                                            liberaLC((yyvsp[0].codigo));
                                                        }
                                                        else {
                                                            printf("Error semántico: Constante ya declarada '%s' (linea: %d)\n", (yyvsp[-4].codigo), yylineno);
                                                            YYERROR; // Aborta el análisis sintáctico****
                                                        }
                                                    }
#line 1316 "sintaxis.tab.c"
    break;

  case 12: /* statement_list: statement_list statement  */
#line 152 "sintaxis.y"
                                            { 
    
                                                concatenaLC((yyvsp[-1].codigo), (yyvsp[0].codigo));
                                                (yyval.codigo) = (yyvsp[-1].codigo);
                                            }
#line 1326 "sintaxis.tab.c"
    break;

  case 13: /* statement_list: %empty  */
#line 157 "sintaxis.y"
                                            { 
                                                (yyval.codigo) = creaLC();
                                            }
#line 1334 "sintaxis.tab.c"
    break;

  case 14: /* statement: ID ASIGN expression DOTCOMMA  */
#line 162 "sintaxis.y"
                                            {   
                                                if (!perteneceTablaS((yyvsp[-3].lexema))){
                                                    printf("Error semántico: Variable no declarada '%s' (linea: %d)\n", (yyvsp[-3].lexema), yylineno);
                                                    YYERROR;
                                                }
                                                else if (esConstante((yyvsp[-3].lexema))){
                                                    printf("Error semántico: Asignación a constante '%s' (linea: %d)\n", (yyvsp[-3].lexema), yylineno);
                                                    YYERROR;
                                                }
                                                else{
                                                    (yyval.codigo) = creaLC();
                                                    concatenaLC((yyval.codigo), (yyvsp[-1].codigo));
                                                    char nombreVar[20];
                                                    // no uso la funcion porque no tengo que recuperar
                                                    sprintf(nombreVar, "_%s", (yyvsp[-3].lexema));
                                                    Operacion op = {
                                                        .op = "sw",
                                                        .res = recuperaResLC((yyvsp[-1].codigo)),
                                                        .arg1 = strdup(nombreVar),
                                                        .arg2 = NULL
                                                    };
                                                    insertaLC((yyval.codigo), finalLC((yyval.codigo)), op);
                                                    inicializaTemporales();
                                                    
                                                }
                                            }
#line 1365 "sintaxis.tab.c"
    break;

  case 15: /* statement: LBRACE statement_list RBRACE  */
#line 188 "sintaxis.y"
                                            { 
                                                (yyval.codigo) = (yyvsp[-1].codigo);
                                            }
#line 1373 "sintaxis.tab.c"
    break;

  case 16: /* statement: IF LPAREN expression RPAREN statement ELSE statement  */
#line 191 "sintaxis.y"
                                                                    { // el funcionamiento en ensamblador es coger la condicion, si va salta al if sino sigue el else y los dos acaban saltando al final
                                                                        (yyval.codigo) = creaLC();
                                                                        char* etiqIf = nuevaEtiq();
                                                                        char* etiqFin = nuevaEtiq();

                                                                        //ANALISIS, si se da se salta al if
                                                                        concatenaLC((yyval.codigo), (yyvsp[-4].codigo));
                                                                        Operacion opCond = operSaltoCond("bnez", recuperaResLC((yyvsp[-4].codigo)), etiqIf);
                                                                        insertaLC((yyval.codigo), finalLC((yyval.codigo)), opCond);
                                                                        inicializaTemporales();
                                                                        
                                                                        liberaTemporal(recuperaResLC((yyvsp[-4].codigo)));

                                                                        //ELSE
                                                                        concatenaLC((yyval.codigo), (yyvsp[0].codigo));
                                                                        
                                                                        
                                                                        Operacion opSaltoFin = {
                                                                            .op = "b",
                                                                            .res = etiqFin,
                                                                            .arg1 = NULL,
                                                                            .arg2 = NULL
                                                                        };
                                                                        insertaLC((yyval.codigo), finalLC((yyval.codigo)), opSaltoFin);
                                                                        inicializaTemporales();

                                                                        // IF
                                                                        Operacion opIf = operEtiq(etiqIf);
                                                                        insertaLC((yyval.codigo), finalLC((yyval.codigo)), opIf);
                                                                        concatenaLC((yyval.codigo), (yyvsp[-2].codigo));
                                                                        

                                                                        // F IN
                                                                        Operacion opFin = operEtiq(etiqFin);
                                                                        insertaLC((yyval.codigo), finalLC((yyval.codigo)), opFin);

                                                                        
                                                                        inicializaTemporales();
                                                                    }
#line 1417 "sintaxis.tab.c"
    break;

  case 17: /* statement: IF LPAREN expression RPAREN statement  */
#line 230 "sintaxis.y"
                                                    {
                                                        (yyval.codigo) = creaLC();
                                                        char* etiqFin = nuevaEtiq();
                                                        
                                                        concatenaLC((yyval.codigo), (yyvsp[-2].codigo));
                                                        Operacion opCond = operSaltoCond("beqz", recuperaResLC((yyvsp[-2].codigo)), etiqFin);
                                                        insertaLC((yyval.codigo), finalLC((yyval.codigo)), opCond);
                                                        liberaTemporal(recuperaResLC((yyvsp[-2].codigo)));

                                                        concatenaLC((yyval.codigo), (yyvsp[0].codigo));

                                                        Operacion opEtiq = operEtiq(etiqFin);
                                                        insertaLC((yyval.codigo), finalLC((yyval.codigo)), opEtiq);

                                                    }
#line 1437 "sintaxis.tab.c"
    break;

  case 18: /* statement: WHILE LPAREN expression RPAREN statement  */
#line 245 "sintaxis.y"
                                                        { 
                                                            (yyval.codigo) = creaLC();
                                                            char* etiqWhile = nuevaEtiq();
                                                            char* etiqFin = nuevaEtiq();

                                                            // Etiqueta para el bucle
                                                            Operacion opEtiqW = operEtiq(etiqWhile);
                                                            insertaLC((yyval.codigo), finalLC((yyval.codigo)), opEtiqW);

                                                            concatenaLC((yyval.codigo), (yyvsp[-2].codigo));

                                                            Operacion opCond = operSaltoCond("beqz", recuperaResLC((yyvsp[-2].codigo)), etiqFin);
                                                            insertaLC((yyval.codigo), finalLC((yyval.codigo)), opCond);
                                                            
                                                            liberaTemporal(recuperaResLC((yyvsp[-2].codigo)));

                                                            concatenaLC((yyval.codigo), (yyvsp[0].codigo));
                                                            
                                                            
                                                            
                                                            
                                                            //SUBIDA A COMPROBAR LA CONDICION
                                                            Operacion opReinicio = {
                                                                .op = "b",
                                                                .res = etiqWhile,
                                                                .arg1 = NULL,
                                                                .arg2 = NULL
                                                            };
                                                            insertaLC((yyval.codigo), finalLC((yyval.codigo)), opReinicio);
                                                            
                                                            //FIN
                                                            Operacion opEtiqFin = operEtiq(etiqFin);
                                                            insertaLC((yyval.codigo), finalLC((yyval.codigo)), opEtiqFin);
                                                        }
#line 1476 "sintaxis.tab.c"
    break;

  case 19: /* statement: PRINT LPAREN print_list RPAREN DOTCOMMA  */
#line 280 "sintaxis.y"
                                                       {
                                                            (yyval.codigo) = creaLC();
                                                            concatenaLC((yyval.codigo), (yyvsp[-2].codigo));
                                                        }
#line 1485 "sintaxis.tab.c"
    break;

  case 20: /* statement: READ LPAREN read_list RPAREN DOTCOMMA  */
#line 285 "sintaxis.y"
                                                        { 
                                                            (yyval.codigo) = creaLC();
                                                            concatenaLC((yyval.codigo), (yyvsp[-2].codigo));
                                                        }
#line 1494 "sintaxis.tab.c"
    break;

  case 21: /* print_list: print_item  */
#line 291 "sintaxis.y"
                                            {
                                                (yyval.codigo) = (yyvsp[0].codigo);
                                            }
#line 1502 "sintaxis.tab.c"
    break;

  case 22: /* print_list: print_list COMMA print_item  */
#line 294 "sintaxis.y"
                                                {
                                                concatenaLC((yyvsp[-2].codigo), (yyvsp[0].codigo));
                                                (yyval.codigo) = (yyvsp[-2].codigo);
                                            }
#line 1511 "sintaxis.tab.c"
    break;

  case 23: /* print_item: expression  */
#line 300 "sintaxis.y"
                                            { 
                                                (yyval.codigo) = (yyvsp[0].codigo);
                                                // li   $v0, 1              se carga la syscall que queremos hacer
                                                // la   $a0, entero         se carga como parametro de la syscall la direccion de la cadena
                                                // syscall
                                                Operacion op1 = {
                                                    .op = "li",
                                                    .res = "$v0",    // primer resultado de syscall
                                                    .arg1 = "1",     // syscall de printear strings
                                                    .arg2 = NULL
                                                };
                                                insertaLC((yyval.codigo), finalLC((yyval.codigo)), op1);

                                                Operacion op2 = {
                                                    .op = "move",
                                                    .res = "$a0",
                                                    .arg1 = recuperaResLC((yyvsp[0].codigo)),
                                                    .arg2 = NULL
                                                };
                                                insertaLC((yyval.codigo), finalLC((yyval.codigo)), op2);
                                                
                                                Operacion op3 = {
                                                    .op = "syscall",
                                                    .res = NULL,
                                                    .arg1 = NULL,
                                                    .arg2 = NULL
                                                };
                                                insertaLC((yyval.codigo), finalLC((yyval.codigo)), op3);

                                                liberaTemporal(recuperaResLC((yyvsp[0].codigo)));
                                            }
#line 1547 "sintaxis.tab.c"
    break;

  case 24: /* print_item: STRING  */
#line 331 "sintaxis.y"
                                                 {
                                                (yyval.codigo) = creaLC();
                                                
                                                Simbolo s;
                                                s.nombre = strdup((yyvsp[0].lexema));
                                                s.tipo = CADENA;
                                                s.valor = contCadenas;
                                                insertaLS(tablaSimb, finalLS(tablaSimb), s);

                                                char nomCadena[50];
                                                sprintf(nomCadena, "$str%d", contCadenas++);  

                                                // li   $v0, 4              se carga la syscall que queremos hacer
                                                // la   $a0, nombreCadena   se carga como parametro de la syscall la direccion de la cadena
                                                // syscall
                                                Operacion op1 = {
                                                    .op = "li",
                                                    .res = "$v0",    // primer resultado de syscall
                                                    .arg1 = "4",     // syscall de printear strings
                                                    .arg2 = NULL
                                                };
                                                insertaLC((yyval.codigo), finalLC((yyval.codigo)), op1);

                                                Operacion op2 = {
                                                    .op = "la",
                                                    .res = "$a0",
                                                    .arg1 = NULL,
                                                    .arg2 = strdup(nomCadena)
                                                };
                                                insertaLC((yyval.codigo), finalLC((yyval.codigo)), op2);
                                                
                                                Operacion op3 = {
                                                    .op = "syscall",
                                                    .res = NULL,
                                                    .arg1 = NULL,
                                                    .arg2 = NULL
                                                };
                                                insertaLC((yyval.codigo), finalLC((yyval.codigo)), op3);

                                            }
#line 1592 "sintaxis.tab.c"
    break;

  case 25: /* read_list: ID  */
#line 373 "sintaxis.y"
                                            {   //COMPRObACIONAS INICIALES
                                                if (!perteneceTablaS((yyvsp[0].lexema))) {
                                                    printf("Error semántico: Variable no declarada '%s' (linea: %d)\n", (yyvsp[0].lexema), yylineno);
                                                    YYERROR;
                                                }
                                                else if (esConstante((yyvsp[0].lexema))){
                                                    printf("Error semántico: Asignación a constante '%s' (linea: %d)\n", (yyvsp[0].lexema), yylineno);
                                                    YYERROR;
                                                }
                                                else{   // aquí iba a crear funciones pero no tenian sentido porque basicamente seria practicamente igual y se llamarian 3 veces contadas
                                                    (yyval.codigo) = creaLC();
                                                    // li   $v0, 5
                                                    // syscalñ
                                                    Operacion op1 = {
                                                        .op = "li",
                                                        .res = "$v0",
                                                        .arg1 = "5",
                                                        .arg2 = NULL
                                                    };
                                                    insertaLC((yyval.codigo), finalLC((yyval.codigo)), op1);

                                                    Operacion op2 = {
                                                        .op = "syscall",
                                                        .res = NULL,
                                                        .arg1 = NULL,
                                                        .arg2 = NULL
                                                    };
                                                    insertaLC((yyval.codigo), finalLC((yyval.codigo)), op2);

                                                    char nombreVar[20];
                                                    sprintf(nombreVar, "_%s", (yyvsp[0].lexema));
                                                    Operacion op3 = {
                                                        .op = "sw",
                                                        .res = "$v0",
                                                        .arg1 = strdup(nombreVar),
                                                        .arg2 = NULL
                                                    };
                                                    insertaLC((yyval.codigo), finalLC((yyval.codigo)), op3);
                                                }
                                            }
#line 1637 "sintaxis.tab.c"
    break;

  case 26: /* read_list: read_list COMMA ID  */
#line 413 "sintaxis.y"
                                                {   
                                                if (!perteneceTablaS((yyvsp[0].lexema))) {
                                                    printf("Error semántico: Variable no declarada '%s' (linea: %d)\n", (yyvsp[0].lexema), yylineno);
                                                    YYERROR;
                                                }
                                                else if (esConstante((yyvsp[0].lexema))){
                                                    printf("Error semántico: Asignación a constante '%s' (linea: %d)\n", (yyvsp[0].lexema), yylineno);
                                                    YYERROR;
                                                }
                                                else{
                                                    (yyval.codigo) = creaLC();
                                                    concatenaLC((yyval.codigo), (yyvsp[-2].codigo));
                                                    // li   $v0, 5
                                                    // syscalñ
                                                    Operacion op1 = {
                                                        .op = "li",
                                                        .res = "$v0",
                                                        .arg1 = "5",
                                                        .arg2 = NULL
                                                    };
                                                    insertaLC((yyval.codigo), finalLC((yyval.codigo)), op1);

                                                    Operacion op2 = {
                                                        .op = "syscall",
                                                        .res = NULL,
                                                        .arg1 = NULL,
                                                        .arg2 = NULL
                                                    };
                                                    insertaLC((yyval.codigo), finalLC((yyval.codigo)), op2);

                                                    char nombreVar[20];
                                                    sprintf(nombreVar, "_%s", (yyvsp[0].lexema));
                                                    Operacion op3 = {
                                                        .op = "sw",
                                                        .res = "$v0",
                                                        .arg1 = strdup(nombreVar),
                                                        .arg2 = NULL
                                                    };
                                                    insertaLC((yyval.codigo), finalLC((yyval.codigo)), op3);
                                                }
                                            }
#line 1683 "sintaxis.tab.c"
    break;

  case 27: /* expression: expression PLUSOP expression  */
#line 456 "sintaxis.y"
                                            { 
                                                (yyval.codigo) = creaLC();
                                                concatenaLC((yyval.codigo), (yyvsp[-2].codigo));
                                                concatenaLC((yyval.codigo), (yyvsp[0].codigo));


                                                Operacion op = crearOpArit("add", recuperaResLC((yyvsp[-2].codigo)), recuperaResLC((yyvsp[0].codigo)), recuperaResLC((yyvsp[-2].codigo)));
                                                liberaTemporal(recuperaResLC((yyvsp[0].codigo)));

                                                guardaResLC((yyval.codigo), strdup(recuperaResLC((yyvsp[-2].codigo))));
                                                insertaLC((yyval.codigo), finalLC((yyval.codigo)), op);
                                            }
#line 1700 "sintaxis.tab.c"
    break;

  case 28: /* expression: expression MINUSOP expression  */
#line 468 "sintaxis.y"
                                            { 
                                                (yyval.codigo) = creaLC();
                                                concatenaLC((yyval.codigo), (yyvsp[-2].codigo));
                                                concatenaLC((yyval.codigo), (yyvsp[0].codigo));


                                                Operacion op = crearOpArit("sub", recuperaResLC((yyvsp[-2].codigo)), recuperaResLC((yyvsp[0].codigo)), recuperaResLC((yyvsp[-2].codigo)));
                                                liberaTemporal(recuperaResLC((yyvsp[0].codigo)));

                                                guardaResLC((yyval.codigo), strdup(recuperaResLC((yyvsp[-2].codigo))));
                                                insertaLC((yyval.codigo), finalLC((yyval.codigo)), op);

                                            }
#line 1718 "sintaxis.tab.c"
    break;

  case 29: /* expression: expression MULTOP expression  */
#line 481 "sintaxis.y"
                                            { 
                                                (yyval.codigo) = creaLC();
                                                concatenaLC((yyval.codigo), (yyvsp[-2].codigo));
                                                concatenaLC((yyval.codigo), (yyvsp[0].codigo));


                                                Operacion op = crearOpArit("mul", recuperaResLC((yyvsp[-2].codigo)), recuperaResLC((yyvsp[0].codigo)), recuperaResLC((yyvsp[-2].codigo)));
                                                liberaTemporal(recuperaResLC((yyvsp[0].codigo)));

                                                guardaResLC((yyval.codigo), strdup(recuperaResLC((yyvsp[-2].codigo))));
                                                insertaLC((yyval.codigo), finalLC((yyval.codigo)), op);

                                            }
#line 1736 "sintaxis.tab.c"
    break;

  case 30: /* expression: expression DIVOP expression  */
#line 494 "sintaxis.y"
                                            { 
                                                (yyval.codigo) = creaLC();
                                                concatenaLC((yyval.codigo), (yyvsp[-2].codigo));
                                                concatenaLC((yyval.codigo), (yyvsp[0].codigo));


                                                Operacion op = crearOpArit("div", recuperaResLC((yyvsp[-2].codigo)), recuperaResLC((yyvsp[0].codigo)), recuperaResLC((yyvsp[-2].codigo)));
                                                liberaTemporal(recuperaResLC((yyvsp[0].codigo)));

                                                guardaResLC((yyval.codigo), strdup(recuperaResLC((yyvsp[-2].codigo))));
                                                insertaLC((yyval.codigo), finalLC((yyval.codigo)), op);
                                            }
#line 1753 "sintaxis.tab.c"
    break;

  case 31: /* expression: LPAREN expression QMARK expression COLON expression RPAREN  */
#line 507 "sintaxis.y"
                                            { 
                                                (yyval.codigo) = creaLC();
                                                char* etiqTrue = nuevaEtiq();
                                                char* etiqFin = nuevaEtiq();
                                                // aclaraacion para el codigo y todo, el ternario es:
                                                // if(expresion1)
                                                //      expresion2
                                                // else
                                                //      expresion3
                                                // eso en ensam es se comprueba la condicion y se salta al true, se hace el else y se salta al final de la operacion
                                                int temp = nuevoTemp();
                                                char tempStr[5];
                                                sprintf(tempStr, "$t%d", temp);
                                                
                                                // ANALISIS CASO
                                                concatenaLC((yyval.codigo), (yyvsp[-5].codigo));
                                                
                                                Operacion op1 = operSaltoCond("bnez", recuperaResLC((yyvsp[-5].codigo)), etiqTrue);

                                                insertaLC((yyval.codigo), finalLC((yyval.codigo)), op1);
                                                
                                                //CASO FLASE
                                                concatenaLC((yyval.codigo), (yyvsp[-1].codigo));
                                                Operacion opFalse = {
                                                    .op = "move",
                                                    .res = strdup(tempStr),
                                                    .arg1 = recuperaResLC((yyvsp[-1].codigo)),
                                                    .arg2 = NULL
                                                };
                                                insertaLC((yyval.codigo), finalLC((yyval.codigo)), opFalse);
                                                
                                                // SALTO FINAL
                                                Operacion op2 = {
                                                    .op = "b",
                                                    .res = etiqFin,
                                                    .arg1 = NULL,
                                                    .arg2 = NULL
                                                };
                                                insertaLC((yyval.codigo), finalLC((yyval.codigo)), op2);


                                                // CASO TRUE
                                                Operacion op3 = operEtiq(etiqTrue);
                                                insertaLC((yyval.codigo), finalLC((yyval.codigo)), op3);

                                                concatenaLC((yyval.codigo), (yyvsp[-3].codigo));
                                                Operacion opTrue = {
                                                    .op = "move",
                                                    .res = strdup(tempStr),
                                                    .arg1 = recuperaResLC((yyvsp[-3].codigo)),
                                                    .arg2 = NULL
                                                };
                                                insertaLC((yyval.codigo), finalLC((yyval.codigo)), opTrue);

                                                // SALTO IFNAL del TRUE
                                                Operacion op4 =  operEtiq(etiqFin);
                                                insertaLC((yyval.codigo), finalLC((yyval.codigo)), op4);

                                                guardaResLC((yyval.codigo), strdup(tempStr));
                                                liberaTemporal(recuperaResLC((yyvsp[-3].codigo)));
                                                liberaTemporal(recuperaResLC((yyvsp[-1].codigo)));

                                                liberaLC((yyvsp[-3].codigo));
                                                liberaLC((yyvsp[-1].codigo));

                                            }
#line 1824 "sintaxis.tab.c"
    break;

  case 32: /* expression: MINUSOP expression  */
#line 574 "sintaxis.y"
                                                  { 
                                                (yyval.codigo) = creaLC();
                                                concatenaLC((yyval.codigo), (yyvsp[0].codigo));

                                                Operacion op = crearOpArit("neg", recuperaResLC((yyvsp[0].codigo)), NULL, recuperaResLC((yyvsp[0].codigo)));

                                                insertaLC((yyval.codigo), finalLC((yyval.codigo)), op);
                                                guardaResLC((yyval.codigo), strdup(recuperaResLC((yyvsp[0].codigo))));
                                            }
#line 1838 "sintaxis.tab.c"
    break;

  case 33: /* expression: LPAREN expression RPAREN  */
#line 583 "sintaxis.y"
                                            { 
                                                (yyval.codigo) = (yyvsp[-1].codigo);
                                            }
#line 1846 "sintaxis.tab.c"
    break;

  case 34: /* expression: ID  */
#line 586 "sintaxis.y"
                                            { 
                                                if (perteneceTablaS((yyvsp[0].lexema))) {
                                                    (yyval.codigo) = creaLC();
                                                    char nombreVar[20];
                                                    sprintf(nombreVar, "_%s", (yyvsp[0].lexema));

                                                    int temp = nuevoTemp();
                                                    char tempStr[5];
                                                    sprintf(tempStr, "$t%d", temp);

                                                    Operacion op = crearOpArit("lw", strdup(nombreVar), NULL, tempStr);

                                                    insertaLC((yyval.codigo), finalLC((yyval.codigo)), op);
                                                    guardaResLC((yyval.codigo), strdup(tempStr));
                                                }
                                                else{
                                                    printf("Error semántico: Variable no declarada '%s' (linea: %d)\n", (yyvsp[0].lexema), yylineno);
                                                    YYERROR;
                                                }

                                            }
#line 1872 "sintaxis.tab.c"
    break;

  case 35: /* expression: ENTERO  */
#line 607 "sintaxis.y"
                                            { 
                                                (yyval.codigo) = creaLC();

                                                int temp = nuevoTemp();
                                                char tempStr[5];
                                                sprintf(tempStr, "$t%d", temp);

                                                Operacion op = crearOpArit("li", (yyvsp[0].lexema), NULL, tempStr);
                                                
                                                insertaLC((yyval.codigo), finalLC((yyval.codigo)), op);
                                                guardaResLC((yyval.codigo), strdup(tempStr));
                                            }
#line 1889 "sintaxis.tab.c"
    break;


#line 1893 "sintaxis.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      yyerror (YY_("syntax error"));
    }

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;
  ++yynerrs;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  YY_ACCESSING_SYMBOL (yystate), yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturnlab;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturnlab;


/*-----------------------------------------------------------.
| yyexhaustedlab -- YYNOMEM (memory exhaustion) comes here.  |
`-----------------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturnlab;


/*----------------------------------------------------------.
| yyreturnlab -- parsing is finished, clean up and return.  |
`----------------------------------------------------------*/
yyreturnlab:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif

  return yyresult;
}

#line 621 "sintaxis.y"


/*          ******* IMPLEMENTACION FUNCIONES VIDEOS ******* 
 */

bool perteneceTablaS(char *nombre){
    return buscaLS(tablaSimb, nombre) != finalLS(tablaSimb);
}

void anadeEntrada(char *nombre, Tipo t, int v){
    Simbolo s;
    s.nombre = strdup(nombre);
    s.tipo = t;
    s.valor = v;
    insertaLS(tablaSimb, finalLS(tablaSimb), s);
}

bool esConstante(char *nombre){
    return recuperaLS(tablaSimb, buscaLS(tablaSimb, nombre)).tipo == CONSTANTE; // sacamos el indice del simbolo en la tabla y luego rescatamos el simbolo y comprobamos el tipo
}

void imprimirTablaS(){
  printf(".data\n");
  PosicionLista pos_actual = inicioLS(tablaSimb);
    while (pos_actual != finalLS(tablaSimb))
    {
        Simbolo sim = recuperaLS(tablaSimb, pos_actual);
        if(sim.tipo != CADENA) printf("_%s:\n\t .word 0\n",sim.nombre); 
        else printf("$str%d:\n\t .asciiz %s\n",sim.valor, sim.nombre); 
        pos_actual = siguienteLS(tablaSimb,pos_actual);
    }
  
}

void imprimeLC(ListaC codigo){
    printf(".text\n");
    printf(".globl main\n");
        printf("main:\n");
    PosicionListaC pos_actual = inicioLC(codigo);
    for (PosicionListaC pos = pos_actual; pos != finalLC(codigo); pos = siguienteLC(codigo, pos)) {
        Operacion op = recuperaLC(codigo, pos);
        
        if (op.op[0] != '$') {
        printf("\t");
        }
        printf("%s", op.op);

        if (op.res) {
            printf(" %s", op.res);
        }
        if (op.arg1) {
            printf(",%s", op.arg1);
        }
        if (op.arg2) {
            printf(",%s", op.arg2);
        }
        printf("\n");
    }
    
    printf("#\tFin\n");
    printf("\tli $v0, 10\n");
    printf("\tsyscall\n");

}

/*         ******* FUNCION SOLO PARA expression ******* 
     PORQUE EL RESTO ENCADENA VARIAS COSAS Y NO TIENE SENTIDO
        PERO LO QUE ES SUMAR, RESTAR, ETC. ES SISTEMATICO
*/
Operacion crearOpArit(char * op, char *oper1, char *oper2, char tempStr[5]){
    Operacion operacion = {
        .op = op,
        .res = strdup(tempStr),
        .arg1 = oper1,
        .arg2 = oper2
    };
    return operacion;
}

Operacion operEtiq (char* etiq){
    Operacion op = {
        .op = etiq,
        .res = NULL,
        .arg1 = NULL,
        .arg2 = NULL
    };
    return op;
}

Operacion operSaltoCond (char* salto, char* exp, char* etiq){
    Operacion op = {
        .op = salto,
        .res = exp,
        .arg1 = etiq,
        .arg2 = NULL
    };
    return op;
}


/*         ******* FUNCION SOLO PARA temporales ******* 
        PARA EL TEMA DE INICIALIZAR, LIBERAR Y RESERVAR EL 
                    PRIMERO QUE HAYA LIBRE
*/
void inicializaTemporales(){
	for(int i = 0; i<N_TEMP;i++)
		tmp[i] = 0;
}

void liberaTemporal(char * temp) {
    int idx = atoi(temp + 2); 
    tmp[idx] = 0;
}

int nuevoTemp(){
	int i = 0;
	while(i<N_TEMP){
		if(tmp[i]==0){
			tmp[i] = 1;
			return i;
		}
		i++;
	}
	printf("No hay temporales libres\n");
    exit(1);
}

/*         ******* FUNCIONES FINALES PARA ETIQUETA Y ERROR *******          */

char* nuevaEtiq() {
    char* etiq = malloc(32);
    sprintf(etiq, "$l%d", contEtiquetas++);
    return etiq;  
}

void yyerror(char *s) {
    extern char *yytext;
    fprintf(stderr, "Error sintáctico en línea %d cerca de '%s': %s\n", yylineno, yytext, s);
}
