/****************************************************************************
**
** Copyright (C) 2012 Klarälvdalens Datakonsult AB, a KDAB Group company, info@kdab.com, author Marc Mutz <marc.mutz@kdab.com>
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtCore module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL21$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia. For licensing terms and
** conditions see http://qt.digia.com/licensing. For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 or version 3 as published by the Free
** Software Foundation and appearing in the file LICENSE.LGPLv21 and
** LICENSE.LGPLv3 included in the packaging of this file. Please review the
** following information to ensure the GNU Lesser General Public License
** requirements will be met: https://www.gnu.org/licenses/lgpl.html and
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights. These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** $QT_END_LICENSE$
**
****************************************************************************/

// BEGIN Google Code

// Copyright (c) 2006, Google Inc.
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
// copyright notice, this list of conditions and the following disclaimer
// in the documentation and/or other materials provided with the
// distribution.
//     * Neither the name of Google Inc. nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

// ----
//
// This code is compiled directly on many platforms, including client
// platforms like Windows, Mac, and embedded systems.  Before making
// any changes here, make sure that you're not breaking any platforms.
//
// Define a small subset of tr1 type traits. The traits we define are:
//   is_integral
//   is_floating_point
//   is_pointer
//   is_enum
//   is_reference
//   is_const
//   is_volatile
//   is_pod
//   has_trivial_constructor
//   has_trivial_copy
//   has_trivial_assign
//   has_trivial_destructor
//   is_signed
//   is_unsigned
//   remove_const
//   remove_volatile
//   remove_cv
//   remove_reference
//   add_reference
//   remove_pointer
//   is_same
//   is_convertible
// We can add more type traits as required.

// Changes from the original implementation:
//  - Move base types from template_util.h directly into this header.
//  - Use Qt macros for long long type differences on Windows.
//  - Enclose in QtPrivate namespace.

public import qt.QtCore.qglobal;

extern(C++, QtPrivate) {

// Types small_ and big_ are guaranteed such that small_.sizeof < big_.sizeof
alias small_ = byte;

struct big_ {
  char dummy[2];
}

// Identity metafunction.
struct identity_(T) {
  alias type = T;
}

// integral_constant, defined in tr1, is a wrapper for an integer
// value. We don't really need this generality; we could get away
// with hardcoding the integer type to bool. We use the fully
// general integer_constant for compatibility with tr1.

struct integral_constant(T, T v) {
  static const T value = v;
  alias value_type = T;
  alias type = integral_constant!(T, v);
}


// Abbreviations: true_type and false_type are structs that represent boolean
// true and false values. Also define the boost.mpl versions of those names,
// true_ and false_.
alias true_type = integral_constant!(bool, true);
alias false_type = integral_constant!(bool, false);
alias true_ = true_type;
alias false_ = false_type;

// if_ is a templatized conditional statement.
// if_<cond, A, B> is a compile time evaluation of cond.
// if_<>.type contains A if cond is true, B otherwise.
struct if_(bool cond, A, B) {
  static if(cond)
    alias type = A;
  else
    alias type = B;
}


// type_equals_ is a template type comparator, similar to Loki IsSameType.
// type_equals_<A, B>.value is true iff "A" is the same type as "B".
//
// New code should prefer base.is_same, defined in base/type_traits.h.
// It is functionally identical, but is_same is the standard spelling.
template type_equals_(A, B)
{
    static if(is(A == B))
        alias type_equals_ = true_;
    else
        alias type_equals_ = false_;
}

// and_ is a template && operator.
// and_<A, B>.value evaluates "A.value && B.value".
alias and_(A, B) = integral_constant!(bool, (A.value && B.value));

// or_ is a template || operator.
// or_<A, B>.value evaluates "A.value || B.value".
alias or_(A, B) = integral_constant!(bool, (A.value || B.value));

struct is_enum(T);
struct is_reference(T);
struct is_pod(T);
struct has_trivial_constructor(T);
struct has_trivial_copy(T);
struct has_trivial_assign(T);
struct has_trivial_destructor(T);
struct remove_const(T);
struct remove_volatile(T);
struct remove_cv(T);
struct remove_reference(T);
struct add_reference(T);
struct remove_pointer(T);
struct is_same(T, U);
struct is_convertible(From, To);

// is_integral is false except for the built-in integer types. A
// cv-qualified type is integral if and only if the underlying type is.

static assert(isIntegral!bool == true, "!");
static assert(isIntegral!char == true, "!");
alias is_integral(T) = if_!(isIntegral!T, true_type, false_type);

// is_floating_point is false except for the built-in floating-point types.
// A cv-qualified type is integral if and only if the underlying type is.
alias is_floating_point(T) = if_!(isFloating!T, true_type, false_type);

// is_pointer is false except for pointer types. A cv-qualified type (e.g.
// "int* const", as opposed to "int const*") is cv-qualified if and only if
// the underlying type is.
alias is_pointer(T) = if_!(isPointer!T, true_type, false_type);

// Specified by TR1 [4.5.1] primary type categories.

// Implementation note:
//
// Each type is either void, integral, floating point, array, pointer,
// reference, member object pointer, member function pointer, enum,
// union or class. Out of these, only integral, floating point, reference,
// extern(C++) class and enum types are potentially convertible to int. Therefore,
// if a type is not a reference, integral, floating point or extern(C++) class and
// is convertible to int, it's a enum. Adding cv-qualification to a type
// does not change whether it's an enum.
//
// Is-convertible-to-int check is done only if all other checks pass,
// because it can't be used with some types (e.g. void or classes with
// inaccessible conversion operators).
alias is_enum(T) = if_!(isEnum!T, true_type, false_type);

// is_reference is false except for reference types.
alias is_reference(alias T) = if_!(isReference!T, true_type, false_type);

// Specified by TR1 [4.5.3] Type Properties
alias is_const(T) = if_!(isConst!T, true_type, false_type);
alias is_volatile(T) = false_type;

// We can't get is_pod right without compiler help, so fail conservatively.
// We will assume it's false except for arithmetic types, enumerations,
// pointers and cv-qualified versions thereof. Note that std.pair<T,U>
// is not a POD even if T and U are PODs.
alias is_pod(T) = if_!(isPOD!T, true_type, false_type);

/+
// We can't get has_trivial_constructor right without compiler help, so
// fail conservatively. We will assume it's false except for: (1) types
// for which is_pod is true. (2) std.pair of types with trivial
// constructors. (3) array of a type with a trivial constructor.
// (4) const versions thereof.
template <class T> struct has_trivial_constructor : is_pod<T> { }
template <class T, extern(C++) class U> struct has_trivial_constructor<std.pair<T, U> >
  : integral_constant<bool,
                      (has_trivial_constructor<T>.value &&
                       has_trivial_constructor<U>.value)> { }
template <class A, int N> struct has_trivial_constructor<A[N]>
  : has_trivial_constructor<A> { }
template <class T> struct has_trivial_constructor<const T>
  : has_trivial_constructor<T> { }

// We can't get has_trivial_copy right without compiler help, so fail
// conservatively. We will assume it's false except for: (1) types
// for which is_pod is true. (2) std.pair of types with trivial copy
// constructors. (3) array of a type with a trivial copy constructor.
// (4) const versions thereof.
template <class T> struct has_trivial_copy : is_pod<T> { }
template <class T, extern(C++) class U> struct has_trivial_copy<std.pair<T, U> >
  : integral_constant<bool,
                      (has_trivial_copy<T>.value &&
                       has_trivial_copy<U>.value)> { }
template <class A, int N> struct has_trivial_copy<A[N]>
  : has_trivial_copy<A> { }
template <class T> struct has_trivial_copy<const T> : has_trivial_copy<T> { }

// We can't get has_trivial_assign right without compiler help, so fail
// conservatively. We will assume it's false except for: (1) types
// for which is_pod is true. (2) std.pair of types with trivial copy
// constructors. (3) array of a type with a trivial assign constructor.
template <class T> struct has_trivial_assign : is_pod<T> { }
template <class T, extern(C++) class U> struct has_trivial_assign<std.pair<T, U> >
  : integral_constant<bool,
                      (has_trivial_assign<T>.value &&
                       has_trivial_assign<U>.value)> { }
template <class A, int N> struct has_trivial_assign<A[N]>
  : has_trivial_assign<A> { }

// We can't get has_trivial_destructor right without compiler help, so
// fail conservatively. We will assume it's false except for: (1) types
// for which is_pod is true. (2) std.pair of types with trivial
// destructors. (3) array of a type with a trivial destructor.
// (4) const versions thereof.
template <class T> struct has_trivial_destructor : is_pod<T> { }
template <class T, extern(C++) class U> struct has_trivial_destructor<std.pair<T, U> >
  : integral_constant<bool,
                      (has_trivial_destructor<T>.value &&
                       has_trivial_destructor<U>.value)> { }
template <class A, int N> struct has_trivial_destructor<A[N]>
  : has_trivial_destructor<A> { }
template <class T> struct has_trivial_destructor<const T>
  : has_trivial_destructor<T> { }
+/
// Specified by TR1 [4.7.1]
template remove_const(T)
{
    static if(is(T == const(U), U))
        alias remove_const = U;
    else
        alias remove_const = T;
}
static assert(is(remove_const!(const int) == int), "!");
static assert(is(remove_const!(float) == float), "!");
static assert(is(remove_const!(const(char)*) == char*), "!");


// Specified by TR1 [4.7.2] Reference modifications.
/+
template<typename T> struct remove_reference { typedef T type; }
template<typename T> struct remove_reference<T&> { typedef T type; }

template <typename T> struct add_reference { typedef T& type; }
template <typename T> struct add_reference<T&> { typedef T& type; }
+/

// Specified by TR1 [4.7.4] Pointer modifications.
template remove_pointer(T)
{
    static if(is(T == U*, U))
        alias remove_pointer = U;
    else
        alias remove_pointer = T;
}
static assert(is(remove_pointer!(int) == int), "!");
static assert(is(remove_pointer!(float*) == float), "!");
static assert(is(remove_pointer!(const(char)*) == const(char)), "!");
static assert(is(remove_pointer!(const(char*)) == const(char)), "!");

// Specified by TR1 [4.6] Relationships between types
alias is_same(T, U) = if_!(is(T == U), true_type, false_type);

// Specified by TR1 [4.6] Relationships between types
alias is_convertible(From, To) = if_!(is(From : To), true_type, false_type);

// a metafunction to invert an integral_constant:
alias not_(T) = integral_constant!(bool, !T.value);

// same, with a bool argument:
alias not_c(bool B) = integral_constant!(bool, !B);

// Checks whether a type is unsigned (T must be convertible to unsigned int):
alias is_unsigned(T) = integral_constant!(bool, isUnsigned!T);

// Checks whether a type is signed (T must be convertible to int):
alias is_signed(T) = integral_constant!(bool, isSigned!T);

static assert(( is_unsigned!quint8.value));
static assert((!is_unsigned!qint8.value));

static assert((!is_signed!quint8.value));
static assert(( is_signed!qint8.value));

static assert(( is_unsigned!quint16.value));
static assert((!is_unsigned!qint16.value));

static assert((!is_signed!quint16.value));
static assert(( is_signed!qint16.value));

static assert(( is_unsigned!quint32.value));
static assert((!is_unsigned!qint32.value));

static assert((!is_signed!quint32.value));
static assert(( is_signed!qint32.value));

static assert(( is_unsigned!quint64.value));
static assert((!is_unsigned!qint64.value));

static assert((!is_signed!quint64.value));
static assert(( is_signed!qint64.value));

} // namespace QtPrivate
