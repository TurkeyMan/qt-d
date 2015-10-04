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
#ifndef QTEXTLAYOUT_H
#define QTEXTLAYOUT_H

public import qt.QtCore.qstring;
public import qt.QtCore.qnamespace;
public import qt.QtCore.qrect;
public import qt.QtCore.qvector;
public import qt.QtGui.qcolor;
public import qt.QtCore.qobject;
public import qt.QtGui.qevent;
public import qt.QtGui.qtextformat;
public import qt.QtGui.qglyphrun;
public import qt.QtGui.qtextcursor;

QT_BEGIN_NAMESPACE


class QTextEngine;
class QFont;
#ifndef QT_NO_RAWFONT
class QRawFont;
#endif
class QRect;
class QRegion;
class QTextFormat;
class QPalette;
class QPainter;

class Q_GUI_EXPORT QTextInlineObject
{
public:
    QTextInlineObject(int i, QTextEngine *e) : itm(i), eng(e) {}
    /+inline+/ QTextInlineObject() : itm(0), eng(0) {}
    /+inline+/ bool isValid() const { return eng; }

    QRectF rect() const;
    qreal width() const;
    qreal ascent() const;
    qreal descent() const;
    qreal height() const;

    Qt.LayoutDirection textDirection() const;

    void setWidth(qreal w);
    void setAscent(qreal a);
    void setDescent(qreal d);

    int textPosition() const;

    int formatIndex() const;
    QTextFormat format() const;

private:
    friend class QTextLayout;
    int itm;
    QTextEngine *eng;
};

class QPaintDevice;
class QTextFormat;
class QTextLine;
class QTextBlock;
class QTextOption;

class Q_GUI_EXPORT QTextLayout
{
public:
    // does itemization
    QTextLayout();
    QTextLayout(ref const(QString) text);
    QTextLayout(ref const(QString) text, ref const(QFont) font, QPaintDevice *paintdevice = 0);
    QTextLayout(ref const(QTextBlock) b);
    ~QTextLayout();

    void setFont(ref const(QFont) f);
    QFont font() const;

#ifndef QT_NO_RAWFONT
    void setRawFont(ref const(QRawFont) rawFont);
#endif

    void setText(ref const(QString) string);
    QString text() const;

    void setTextOption(ref const(QTextOption) option);
    ref const(QTextOption) textOption() const;

    void setPreeditArea(int position, ref const(QString) text);
    int preeditAreaPosition() const;
    QString preeditAreaText() const;

    struct FormatRange {
        int start;
        int length;
        QTextCharFormat format;
    };
    void setAdditionalFormats(ref const(QList<FormatRange>) overrides);
    QList<FormatRange> additionalFormats() const;
    void clearAdditionalFormats();

    void setCacheEnabled(bool enable);
    bool cacheEnabled() const;

    void setCursorMoveStyle(Qt.CursorMoveStyle style);
    Qt.CursorMoveStyle cursorMoveStyle() const;

    void beginLayout();
    void endLayout();
    void clearLayout();

    QTextLine createLine();

    int lineCount() const;
    QTextLine lineAt(int i) const;
    QTextLine lineForTextPosition(int pos) const;

    enum CursorMode {
        SkipCharacters,
        SkipWords
    };
    bool isValidCursorPosition(int pos) const;
    int nextCursorPosition(int oldPos, CursorMode mode = SkipCharacters) const;
    int previousCursorPosition(int oldPos, CursorMode mode = SkipCharacters) const;
    int leftCursorPosition(int oldPos) const;
    int rightCursorPosition(int oldPos) const;

    void draw(QPainter *p, ref const(QPointF) pos, ref const(QVector<FormatRange>) selections = QVector<FormatRange>(),
              ref const(QRectF) clip = QRectF()) const;
    void drawCursor(QPainter *p, ref const(QPointF) pos, int cursorPosition) const;
    void drawCursor(QPainter *p, ref const(QPointF) pos, int cursorPosition, int width) const;

    QPointF position() const;
    void setPosition(ref const(QPointF) p);

    QRectF boundingRect() const;

    qreal minimumWidth() const;
    qreal maximumWidth() const;

#if !defined(QT_NO_RAWFONT)
    QList<QGlyphRun> glyphRuns(int from = -1, int length = -1) const;
#endif

    QTextEngine *engine() const { return d; }
    void setFlags(int flags);
private:
    QTextLayout(QTextEngine *e) : d(e) {}
    mixin Q_DISABLE_COPY;

    friend class QPainter;
    friend class QGraphicsSimpleTextItemPrivate;
    friend class QGraphicsSimpleTextItem;
    friend void qt_format_text(ref const(QFont) font, ref const(QRectF) _r, int tf, const(QTextOption)* , ref const(QString) str,
                               QRectF *brect, int tabstops, int* tabarray, int tabarraylen,
                               QPainter *painter);
    QTextEngine *d;
};


class Q_GUI_EXPORT QTextLine
{
public:
    /+inline+/ QTextLine() : index(0), eng(0) {}
    /+inline+/ bool isValid() const { return eng; }

    QRectF rect() const;
    qreal x() const;
    qreal y() const;
    qreal width() const;
    qreal ascent() const;
    qreal descent() const;
    qreal height() const;
    qreal leading() const;

    void setLeadingIncluded(bool included);
    bool leadingIncluded() const;

    qreal naturalTextWidth() const;
    qreal horizontalAdvance() const;
    QRectF naturalTextRect() const;

    enum Edge {
        Leading,
        Trailing
    };
    enum CursorPosition {
        CursorBetweenCharacters,
        CursorOnCharacter
    };

    /* cursorPos gets set to the valid position */
    qreal cursorToX(int *cursorPos, Edge edge = Leading) const;
    /+inline+/ qreal cursorToX(int cursorPos, Edge edge = Leading) const { return cursorToX(&cursorPos, edge); }
    int xToCursor(qreal x, CursorPosition = CursorBetweenCharacters) const;

    void setLineWidth(qreal width);
    void setNumColumns(int columns);
    void setNumColumns(int columns, qreal alignmentWidth);

    void setPosition(ref const(QPointF) pos);
    QPointF position() const;

    int textStart() const;
    int textLength() const;

    int lineNumber() const { return index; }

    void draw(QPainter *p, ref const(QPointF) point, const QTextLayout::FormatRange *selection = 0) const;

#if !defined(QT_NO_RAWFONT)
    QList<QGlyphRun> glyphRuns(int from = -1, int length = -1) const;
#endif

private:
    QTextLine(int line, QTextEngine *e) : index(line), eng(e) {}
    void layout_helper(int numGlyphs);

    friend class QTextLayout;
    friend class QTextFragment;
    int index;
    QTextEngine *eng;
};

QT_END_NAMESPACE

#endif // QTEXTLAYOUT_H
