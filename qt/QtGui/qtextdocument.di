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

#ifndef QTEXTDOCUMENT_H
#define QTEXTDOCUMENT_H

public import qt.QtCore.qobject;
public import qt.QtCore.qsize;
public import qt.QtCore.qrect;
public import qt.QtCore.qvariant;
public import qt.QtGui.qfont;
public import qt.QtCore.qurl;

QT_BEGIN_NAMESPACE


class QTextFormatCollection;
class QTextListFormat;
class QRect;
class QPainter;
class QPagedPaintDevice;
class QAbstractTextDocumentLayout;
class QPoint;
class QTextObject;
class QTextFormat;
class QTextFrame;
class QTextBlock;
class QTextCodec;
class QVariant;
class QRectF;
class QTextOption;
class QTextCursor;

template<typename T> class QVector;

#ifndef Q_QDOC // Workaround for QTBUG-35230
namespace Qt
{
    Q_GUI_EXPORT bool mightBeRichText(ref const(QString));
    Q_GUI_EXPORT QString convertFromPlainText(ref const(QString) plain, WhiteSpaceMode mode = WhiteSpacePre);

#ifndef QT_NO_TEXTCODEC
    Q_GUI_EXPORT QTextCodec *codecForHtml(ref const(QByteArray) ba);
#endif
}
#endif // Q_QDOC

class Q_GUI_EXPORT QAbstractUndoItem
{
public:
    /+virtual+/ ~QAbstractUndoItem() = 0;
    /+virtual+/ void undo() = 0;
    /+virtual+/ void redo() = 0;
};

/+inline+/ QAbstractUndoItem::~QAbstractUndoItem()
{
}

class QTextDocumentPrivate;

class Q_GUI_EXPORT QTextDocument : public QObject
{
    mixin Q_OBJECT;

    mixin Q_PROPERTY!(bool, "undoRedoEnabled", "READ", "isUndoRedoEnabled", "WRITE", "setUndoRedoEnabled");
    mixin Q_PROPERTY!(bool, "modified", "READ", "isModified", "WRITE", "setModified", "DESIGNABLE", "false");
    mixin Q_PROPERTY!(QSizeF, "pageSize", "READ", "pageSize", "WRITE", "setPageSize");
    mixin Q_PROPERTY!(QFont, "defaultFont", "READ", "defaultFont", "WRITE", "setDefaultFont");
    mixin Q_PROPERTY!(bool, "useDesignMetrics", "READ", "useDesignMetrics", "WRITE", "setUseDesignMetrics");
    mixin Q_PROPERTY!(QSizeF, "size", "READ", "size");
    mixin Q_PROPERTY!(qreal, "textWidth", "READ", "textWidth", "WRITE", "setTextWidth");
    mixin Q_PROPERTY!(int, "blockCount", "READ", "blockCount");
    mixin Q_PROPERTY!(qreal, "indentWidth", "READ", "indentWidth", "WRITE", "setIndentWidth");
#ifndef QT_NO_CSSPARSER
    mixin Q_PROPERTY!(QString, "defaultStyleSheet", "READ", "defaultStyleSheet", "WRITE", "setDefaultStyleSheet");
#endif
    mixin Q_PROPERTY!(int, "maximumBlockCount", "READ", "maximumBlockCount", "WRITE", "setMaximumBlockCount");
    mixin Q_PROPERTY!(qreal, "documentMargin", "READ", "documentMargin", "WRITE", "setDocumentMargin");
    QDOC_PROPERTY(QTextOption defaultTextOption READ defaultTextOption WRITE setDefaultTextOption)
    mixin Q_PROPERTY!(QUrl, "baseUrl", "READ", "baseUrl", "WRITE", "setBaseUrl", "NOTIFY", "baseUrlChanged");

public:
    explicit QTextDocument(QObject *parent = 0);
    explicit QTextDocument(ref const(QString) text, QObject *parent = 0);
    ~QTextDocument();

    QTextDocument *clone(QObject *parent = 0) const;

    bool isEmpty() const;
    /+virtual+/ void clear();

    void setUndoRedoEnabled(bool enable);
    bool isUndoRedoEnabled() const;

    bool isUndoAvailable() const;
    bool isRedoAvailable() const;

    int availableUndoSteps() const;
    int availableRedoSteps() const;

    int revision() const;

    void setDocumentLayout(QAbstractTextDocumentLayout *layout);
    QAbstractTextDocumentLayout *documentLayout() const;

    enum MetaInformation {
        DocumentTitle,
        DocumentUrl
    };
    void setMetaInformation(MetaInformation info, ref const(QString) );
    QString metaInformation(MetaInformation info) const;

#ifndef QT_NO_TEXTHTMLPARSER
    QString toHtml(ref const(QByteArray) encoding = QByteArray()) const;
    void setHtml(ref const(QString) html);
#endif

    QString toPlainText() const;
    void setPlainText(ref const(QString) text);

    QChar characterAt(int pos) const;

    enum FindFlag
    {
        FindBackward        = 0x00001,
        FindCaseSensitively = 0x00002,
        FindWholeWords      = 0x00004
    };
    Q_DECLARE_FLAGS(FindFlags, FindFlag)

    QTextCursor find(ref const(QString) subString, int from = 0, FindFlags options = 0) const;
    QTextCursor find(ref const(QString) subString, ref const(QTextCursor) from, FindFlags options = 0) const;

    QTextCursor find(ref const(QRegExp) expr, int from = 0, FindFlags options = 0) const;
    QTextCursor find(ref const(QRegExp) expr, ref const(QTextCursor) from, FindFlags options = 0) const;

    QTextFrame *frameAt(int pos) const;
    QTextFrame *rootFrame() const;

    QTextObject *object(int objectIndex) const;
    QTextObject *objectForFormat(ref const(QTextFormat) ) const;

    QTextBlock findBlock(int pos) const;
    QTextBlock findBlockByNumber(int blockNumber) const;
    QTextBlock findBlockByLineNumber(int blockNumber) const;
    QTextBlock begin() const;
    QTextBlock end() const;

    QTextBlock firstBlock() const;
    QTextBlock lastBlock() const;

    void setPageSize(ref const(QSizeF) size);
    QSizeF pageSize() const;

    void setDefaultFont(ref const(QFont) font);
    QFont defaultFont() const;

    int pageCount() const;

    bool isModified() const;

    void print(QPagedPaintDevice *printer) const;

    enum ResourceType {
        HtmlResource  = 1,
        ImageResource = 2,
        StyleSheetResource = 3,

        UserResource  = 100
    };

    QVariant resource(int type, ref const(QUrl) name) const;
    void addResource(int type, ref const(QUrl) name, ref const(QVariant) resource);

    QVector<QTextFormat> allFormats() const;

    void markContentsDirty(int from, int length);

    void setUseDesignMetrics(bool b);
    bool useDesignMetrics() const;

    void drawContents(QPainter *painter, ref const(QRectF) rect = QRectF());

    void setTextWidth(qreal width);
    qreal textWidth() const;

    qreal idealWidth() const;

    qreal indentWidth() const;
    void setIndentWidth(qreal width);

    qreal documentMargin() const;
    void setDocumentMargin(qreal margin);

    void adjustSize();
    QSizeF size() const;

    int blockCount() const;
    int lineCount() const;
    int characterCount() const;

#ifndef QT_NO_CSSPARSER
    void setDefaultStyleSheet(ref const(QString) sheet);
    QString defaultStyleSheet() const;
#endif

    void undo(QTextCursor *cursor);
    void redo(QTextCursor *cursor);

    enum Stacks {
        UndoStack = 0x01,
        RedoStack = 0x02,
        UndoAndRedoStacks = UndoStack | RedoStack
    };
    void clearUndoRedoStacks(Stacks historyToClear = UndoAndRedoStacks);

    int maximumBlockCount() const;
    void setMaximumBlockCount(int maximum);

    QTextOption defaultTextOption() const;
    void setDefaultTextOption(ref const(QTextOption) option);

    QUrl baseUrl() const;
    void setBaseUrl(ref const(QUrl) url);

    Qt.CursorMoveStyle defaultCursorMoveStyle() const;
    void setDefaultCursorMoveStyle(Qt.CursorMoveStyle style);

Q_SIGNALS:
    void contentsChange(int from, int charsRemoved, int charsAdded);
    void contentsChanged();
    void undoAvailable(bool);
    void redoAvailable(bool);
    void undoCommandAdded();
    void modificationChanged(bool m);
    void cursorPositionChanged(ref const(QTextCursor) cursor);
    void blockCountChanged(int newBlockCount);
    void baseUrlChanged(ref const(QUrl) url);
    void documentLayoutChanged();

public Q_SLOTS:
    void undo();
    void redo();
    void appendUndoItem(QAbstractUndoItem *);
    void setModified(bool m = true);

protected:
    /+virtual+/ QTextObject *createObject(ref const(QTextFormat) f);
    Q_INVOKABLE /+virtual+/ QVariant loadResource(int type, ref const(QUrl) name);

    QTextDocument(QTextDocumentPrivate &dd, QObject *parent);
public:
    QTextDocumentPrivate *docHandle() const;
private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
    friend class QTextObjectPrivate;
};

Q_DECLARE_OPERATORS_FOR_FLAGS(QTextDocument::FindFlags)

QT_END_NAMESPACE

#endif // QTEXTDOCUMENT_H
