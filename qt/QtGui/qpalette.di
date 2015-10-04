/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtGui module of the Qt Toolkit.
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

#ifndef QPALETTE_H
#define QPALETTE_H

public import qt.QtGui.qwindowdefs;
public import qt.QtGui.qcolor;
public import qt.QtGui.qbrush;

QT_BEGIN_NAMESPACE


class QPalettePrivate;
class QVariant;

class Q_GUI_EXPORT QPalette
{
    Q_GADGET
    Q_ENUMS(ColorGroup ColorRole)
public:
    QPalette();
    QPalette(ref const(QColor) button);
    QPalette(Qt.GlobalColor button);
    QPalette(ref const(QColor) button, ref const(QColor) window);
    QPalette(ref const(QBrush) windowText, ref const(QBrush) button, ref const(QBrush) light,
             ref const(QBrush) dark, ref const(QBrush) mid, ref const(QBrush) text,
             ref const(QBrush) bright_text, ref const(QBrush) base, ref const(QBrush) window);
    QPalette(ref const(QColor) windowText, ref const(QColor) window, ref const(QColor) light,
             ref const(QColor) dark, ref const(QColor) mid, ref const(QColor) text, ref const(QColor) base);
    QPalette(ref const(QPalette) palette);
    ~QPalette();
    QPalette &operator=(ref const(QPalette) palette);
#ifdef Q_COMPILER_RVALUE_REFS
    QPalette(QPalette &&other) Q_DECL_NOTHROW
        : d(other.d), data(other.data) { other.d = Q_NULLPTR; }
    /+inline+/ QPalette &operator=(QPalette &&other)
    {
        for_faster_swapping_dont_use = other.for_faster_swapping_dont_use;
        qSwap(d, other.d); return *this;
    }
#endif

    void swap(QPalette &other) {
        qSwap(d, other.d);
        qSwap(for_faster_swapping_dont_use, other.for_faster_swapping_dont_use);
    }

    operator QVariant() const;

    // Do not change the order, the serialization format depends on it
    enum ColorGroup { Active, Disabled, Inactive, NColorGroups, Current, All, Normal = Active };
    enum ColorRole { WindowText, Button, Light, Midlight, Dark, Mid,
                     Text, BrightText, ButtonText, Base, Window, Shadow,
                     Highlight, HighlightedText,
                     Link, LinkVisited,
                     AlternateBase,
                     NoRole,
                     ToolTipBase, ToolTipText,
                     NColorRoles = ToolTipText + 1,
                     Foreground = WindowText, Background = Window
                   };

    /+inline+/ ColorGroup currentColorGroup() const { return static_cast<ColorGroup>(data.current_group); }
    /+inline+/ void setCurrentColorGroup(ColorGroup cg) { data.current_group = cg; }

    /+inline+/ ref const(QColor) color(ColorGroup cg, ColorRole cr) const
    { return brush(cg, cr).color(); }
    ref const(QBrush) brush(ColorGroup cg, ColorRole cr) const;
    /+inline+/ void setColor(ColorGroup cg, ColorRole cr, ref const(QColor) color);
    /+inline+/ void setColor(ColorRole cr, ref const(QColor) color);
    /+inline+/ void setBrush(ColorRole cr, ref const(QBrush) brush);
    bool isBrushSet(ColorGroup cg, ColorRole cr) const;
    void setBrush(ColorGroup cg, ColorRole cr, ref const(QBrush) brush);
    void setColorGroup(ColorGroup cr, ref const(QBrush) windowText, ref const(QBrush) button,
                       ref const(QBrush) light, ref const(QBrush) dark, ref const(QBrush) mid,
                       ref const(QBrush) text, ref const(QBrush) bright_text, ref const(QBrush) base,
                       ref const(QBrush) window);
    bool isEqual(ColorGroup cr1, ColorGroup cr2) const;

    /+inline+/ ref const(QColor) color(ColorRole cr) const { return color(Current, cr); }
    /+inline+/ ref const(QBrush) brush(ColorRole cr) const { return brush(Current, cr); }
    /+inline+/ ref const(QBrush) foreground() const { return brush(WindowText); }
    /+inline+/ ref const(QBrush) windowText() const { return brush(WindowText); }
    /+inline+/ ref const(QBrush) button() const { return brush(Button); }
    /+inline+/ ref const(QBrush) light() const { return brush(Light); }
    /+inline+/ ref const(QBrush) dark() const { return brush(Dark); }
    /+inline+/ ref const(QBrush) mid() const { return brush(Mid); }
    /+inline+/ ref const(QBrush) text() const { return brush(Text); }
    /+inline+/ ref const(QBrush) base() const { return brush(Base); }
    /+inline+/ ref const(QBrush) alternateBase() const { return brush(AlternateBase); }
    /+inline+/ ref const(QBrush) toolTipBase() const { return brush(ToolTipBase); }
    /+inline+/ ref const(QBrush) toolTipText() const { return brush(ToolTipText); }
    /+inline+/ ref const(QBrush) background() const { return brush(Window); }
    /+inline+/ ref const(QBrush) window() const { return brush(Window); }
    /+inline+/ ref const(QBrush) midlight() const { return brush(Midlight); }
    /+inline+/ ref const(QBrush) brightText() const { return brush(BrightText); }
    /+inline+/ ref const(QBrush) buttonText() const { return brush(ButtonText); }
    /+inline+/ ref const(QBrush) shadow() const { return brush(Shadow); }
    /+inline+/ ref const(QBrush) highlight() const { return brush(Highlight); }
    /+inline+/ ref const(QBrush) highlightedText() const { return brush(HighlightedText); }
    /+inline+/ ref const(QBrush) link() const { return brush(Link); }
    /+inline+/ ref const(QBrush) linkVisited() const { return brush(LinkVisited); }

    bool operator==(ref const(QPalette) p) const;
    /+inline+/ bool operator!=(ref const(QPalette) p) const { return !(operator==(p)); }
    bool isCopyOf(ref const(QPalette) p) const;

#if QT_DEPRECATED_SINCE(5, 0)
    QT_DEPRECATED /+inline+/ int serialNumber() const { return cacheKey() >> 32; }
#endif
    qint64 cacheKey() const;

    QPalette resolve(ref const(QPalette) ) const;
    /+inline+/ uint resolve() const { return data.resolve_mask; }
    /+inline+/ void resolve(uint mask) { data.resolve_mask = mask; }

private:
    void setColorGroup(ColorGroup cr, ref const(QBrush) windowText, ref const(QBrush) button,
                       ref const(QBrush) light, ref const(QBrush) dark, ref const(QBrush) mid,
                       ref const(QBrush) text, ref const(QBrush) bright_text,
                       ref const(QBrush) base, ref const(QBrush) alternate_base,
                       ref const(QBrush) window, ref const(QBrush) midlight,
                       ref const(QBrush) button_text, ref const(QBrush) shadow,
                       ref const(QBrush) highlight, ref const(QBrush) highlighted_text,
                       ref const(QBrush) link, ref const(QBrush) link_visited);
    void setColorGroup(ColorGroup cr, ref const(QBrush) windowText, ref const(QBrush) button,
                       ref const(QBrush) light, ref const(QBrush) dark, ref const(QBrush) mid,
                       ref const(QBrush) text, ref const(QBrush) bright_text,
                       ref const(QBrush) base, ref const(QBrush) alternate_base,
                       ref const(QBrush) window, ref const(QBrush) midlight,
                       ref const(QBrush) button_text, ref const(QBrush) shadow,
                       ref const(QBrush) highlight, ref const(QBrush) highlighted_text,
                       ref const(QBrush) link, ref const(QBrush) link_visited,
                       ref const(QBrush) toolTipBase, ref const(QBrush) toolTipText);
    void init();
    void detach();

    QPalettePrivate *d;
    struct Data {
        uint current_group : 4;
        uint resolve_mask : 28;
    };
    union {
        Data data;
        quint32 for_faster_swapping_dont_use;
    };
    friend Q_GUI_EXPORT QDataStream &operator<<(QDataStream &s, ref const(QPalette) p);
};

Q_DECLARE_SHARED(QPalette)

/+inline+/ void QPalette::setColor(ColorGroup acg, ColorRole acr,
                               ref const(QColor) acolor)
{ setBrush(acg, acr, QBrush(acolor)); }
/+inline+/ void QPalette::setColor(ColorRole acr, ref const(QColor) acolor)
{ setColor(All, acr, acolor); }
/+inline+/ void QPalette::setBrush(ColorRole acr, ref const(QBrush) abrush)
{ setBrush(All, acr, abrush); }

/*****************************************************************************
  QPalette stream functions
 *****************************************************************************/
#ifndef QT_NO_DATASTREAM
Q_GUI_EXPORT QDataStream &operator<<(QDataStream &ds, ref const(QPalette) p);
Q_GUI_EXPORT QDataStream &operator>>(QDataStream &ds, QPalette &p);
#endif // QT_NO_DATASTREAM

#ifndef QT_NO_DEBUG_STREAM
Q_GUI_EXPORT QDebug operator<<(QDebug, ref const(QPalette) );
#endif

QT_END_NAMESPACE

#endif // QPALETTE_H
