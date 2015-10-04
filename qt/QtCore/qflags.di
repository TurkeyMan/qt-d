/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
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

module qt.QtCore.qflags;

public import qt.QtCore.qglobal;

public import qt.QtCore.qtypeinfo;
public import qt.QtCore.qtypetraits;

version(Q_COMPILER_INITIALIZER_LISTS)
    public import initializer_list;

extern(C++) struct QFlag
{
    alias i this;

    this(int i) { this.i = i; }

private:
    int i;
}
static assert(QTypeInfo!(QFlag!int).isComplex == false, "!");
static assert(QTypeInfo!(QFlag!byte).isStatic == false, "!");

extern(C++) struct QIncompatibleFlag
{
    this(int i) { this.i = i; }

private:
    int i;
}
static assert(QTypeInfo!(QIncompatibleFlag!int).isComplex == false, "!");
static assert(QTypeInfo!(QIncompatibleFlag!uint).isStatic == false, "!");

version(Q_NO_TYPESAFE_FLAGS) {

mixin template Q_DECLARE_FLAGS(string Flags, Enum)
{
    mixin("alias "~Flags~" = uint;");
}
mixin template Q_DECLARE_OPERATORS_FOR_FLAGS(Flags) {}

} else { // Q_NO_TYPESAFE_FLAGS

extern(C++) class QFlags(Enum)
{
private:
    static assert(Enum.sizeof <= int.sizeof, "QFlags uses an int as storage, so an enum with underlying long will overflow.");

public:
    alias get this;

    static if(isUnsigned!Enum)
        alias Int = uint;
    else
        alias Int = int;

    alias enum_type = Enum;

    // compiler-generated copy/move ctor/assignment operators are fine!
    /+inline+/ this(Enum f) { i = cast(Int)f; }
    /+inline+/ this(QFlag f) { i = f; }

    /+inline+/ ref QFlags opOpAssign(string op)(int mask)  if(op == "&") { i &= mask; return this; }
    /+inline+/ ref QFlags opOpAssign(string op)(uint mask) if(op == "&") { i &= mask; return this; }
    /+inline+/ ref QFlags opOpAssign(string op)(Enum mask) if(op == "&") { i &= cast(Int)mask; return this; }
    /+inline+/ ref QFlags opOpAssign(string op)(QFlags f)  if(op == "|") { i |= f.i; return this; }
    /+inline+/ ref QFlags opOpAssign(string op)(Enum f)    if(op == "|") { i |= cast(Int)f; return this; }
    /+inline+/ ref QFlags opOpAssign(string op)(QFlags f)  if(op == "^") { i ^= f.i; return this; }
    /+inline+/ ref QFlags opOpAssign(string op)(Enum f)    if(op == "^") { i ^= cast(Int)f; return this; }

    /+inline+/ Int get() const { return i; }

    /+inline+/ QFlags opBinary(string op)(QFlags f) const  if(op == "|") { return QFlags(QFlag(i | f.i)); }
    /+inline+/ QFlags opBinary(string op)(Enum f) const    if(op == "|") { return QFlags(QFlag(i | cast(Int)f)); }
    /+inline+/ QFlags opBinary(string op)(QFlags f) const  if(op == "^") { return QFlags(QFlag(i ^ f.i)); }
    /+inline+/ QFlags opBinary(string op)(Enum f) const    if(op == "^") { return QFlags(QFlag(i ^ cast(Int)f)); }
    /+inline+/ QFlags opBinary(string op)(int mask) const  if(op == "&") { return QFlags(QFlag(i & mask)); }
    /+inline+/ QFlags opBinary(string op)(uint mask) const if(op == "&") { return QFlags(QFlag(i & mask)); }
    /+inline+/ QFlags opBinary(string op)(Enum f) const    if(op == "&") { return QFlags(QFlag(i & cast(Int)f)); }
    /+inline+/ QFlags opBinary(string op)() const          if(op == "~") { return QFlags(QFlag(~i)); }

    /+inline+/ bool opUnary(string op)() const if(op == "!") { return !i; }

    /+inline+/ bool testFlag(Enum f) const { return (i & cast(Int)f) == cast(Int)f && (cast(Int)f != 0 || i == cast(Int)f); }
private:

    Int i;
}

mixin template Q_DECLARE_FLAGS(string Flags, Enum)
{
    mixin("alias "~Flags~" = QFlags!Enum;");
}

mixin template Q_DECLARE_INCOMPATIBLE_FLAGS(Flags)
{
    /+inline+/ QIncompatibleFlag opBinary(string op)(Flags.enum_type f1, int f2) if(op == "|")
    {
        return QIncompatibleFlag(cast(int)f1 | f2);
    }
}

mixin template Q_DECLARE_OPERATORS_FOR_FLAGS(Flags)
{
    /+inline+/ QFlags!(Flags.enum_type) opBinary(string op)(Flags.enum_type f1, Flags.enum_type f2) if(op == "|")
    {
        return cast(QFlags!(Flags.enum_type))f1 | f2;
    }
    /+inline+/ QFlags!(Flags.enum_type) opBinary(string op)(Flags.enum_type f1, QFlags!(Flags.enum_type) f2) if(op == "|")
    {
        return f2 | f1;
    }
    mixin Q_DECLARE_INCOMPATIBLE_FLAGS!Flags;
}

} // Q_NO_TYPESAFE_FLAGS
