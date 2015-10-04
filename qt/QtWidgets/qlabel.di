/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtWidgets module of the Qt Toolkit.
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

#ifndef QLABEL_H
#define QLABEL_H

public import qt.QtWidgets.qframe;

QT_BEGIN_NAMESPACE


class QLabelPrivate;

class Q_WIDGETS_EXPORT QLabel : public QFrame
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QString, "text", "READ", "text", "WRITE", "setText");
    mixin Q_PROPERTY!(Qt.TextFormat, "textFormat", "READ", "textFormat", "WRITE", "setTextFormat");
    mixin Q_PROPERTY!(QPixmap, "pixmap", "READ", "pixmap", "WRITE", "setPixmap");
    mixin Q_PROPERTY!(bool, "scaledContents", "READ", "hasScaledContents", "WRITE", "setScaledContents");
    mixin Q_PROPERTY!(Qt.Alignment, "alignment", "READ", "alignment", "WRITE", "setAlignment");
    mixin Q_PROPERTY!(bool, "wordWrap", "READ", "wordWrap", "WRITE", "setWordWrap");
    mixin Q_PROPERTY!(int, "margin", "READ", "margin", "WRITE", "setMargin");
    mixin Q_PROPERTY!(int, "indent", "READ", "indent", "WRITE", "setIndent");
    mixin Q_PROPERTY!(bool, "openExternalLinks", "READ", "openExternalLinks", "WRITE", "setOpenExternalLinks");
    mixin Q_PROPERTY!(Qt.TextInteractionFlags, "textInteractionFlags", "READ", "textInteractionFlags", "WRITE", "setTextInteractionFlags");
    mixin Q_PROPERTY!(bool, "hasSelectedText", "READ", "hasSelectedText");
    mixin Q_PROPERTY!(QString, "selectedText", "READ", "selectedText");

public:
    explicit QLabel(QWidget *parent=0, Qt.WindowFlags f=0);
    explicit QLabel(ref const(QString) text, QWidget *parent=0, Qt.WindowFlags f=0);
    ~QLabel();

    QString text() const;
    const(QPixmap)* pixmap() const;
#ifndef QT_NO_PICTURE
    const(QPicture)* picture() const;
#endif
#ifndef QT_NO_MOVIE
    QMovie *movie() const;
#endif

    Qt.TextFormat textFormat() const;
    void setTextFormat(Qt.TextFormat);

    Qt.Alignment alignment() const;
    void setAlignment(Qt.Alignment);

    void setWordWrap(bool on);
    bool wordWrap() const;

    int indent() const;
    void setIndent(int);

    int margin() const;
    void setMargin(int);

    bool hasScaledContents() const;
    void setScaledContents(bool);
    QSize sizeHint() const;
    QSize minimumSizeHint() const;
#ifndef QT_NO_SHORTCUT
    void setBuddy(QWidget *);
    QWidget *buddy() const;
#endif
    int heightForWidth(int) const;

    bool openExternalLinks() const;
    void setOpenExternalLinks(bool open);

    void setTextInteractionFlags(Qt.TextInteractionFlags flags);
    Qt.TextInteractionFlags textInteractionFlags() const;

    void setSelection(int, int);
    bool hasSelectedText() const;
    QString selectedText() const;
    int selectionStart() const;

public Q_SLOTS:
    void setText(ref const(QString) );
    void setPixmap(ref const(QPixmap) );
#ifndef QT_NO_PICTURE
    void setPicture(ref const(QPicture) );
#endif
#ifndef QT_NO_MOVIE
    void setMovie(QMovie *movie);
#endif
    void setNum(int);
    void setNum(double);
    void clear();

Q_SIGNALS:
    void linkActivated(ref const(QString) link);
    void linkHovered(ref const(QString) link);

protected:
    bool event(QEvent *e);
    void keyPressEvent(QKeyEvent *ev);
    void paintEvent(QPaintEvent *);
    void changeEvent(QEvent *);
    void mousePressEvent(QMouseEvent *ev);
    void mouseMoveEvent(QMouseEvent *ev);
    void mouseReleaseEvent(QMouseEvent *ev);
    void contextMenuEvent(QContextMenuEvent *ev);
    void focusInEvent(QFocusEvent *ev);
    void focusOutEvent(QFocusEvent *ev);
    bool focusNextPrevChild(bool next);


private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
#ifndef QT_NO_MOVIE
    Q_PRIVATE_SLOT(d_func(), void _q_movieUpdated(ref const(QRect)))
    Q_PRIVATE_SLOT(d_func(), void _q_movieResized(ref const(QSize)))
#endif
    Q_PRIVATE_SLOT(d_func(), void _q_linkHovered(ref const(QString) ))

    friend class QTipLabel;
    friend class QMessageBoxPrivate;
    friend class QBalloonTip;
};

QT_END_NAMESPACE

#endif // QLABEL_H
