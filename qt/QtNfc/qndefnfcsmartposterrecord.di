/***************************************************************************
 **
 ** Copyright (C) 2011 - 2012 Research In Motion
 ** Contact: http://www.qt-project.org/legal
 **
 ** This file is part of the QtNfc module of the Qt Toolkit.
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

#ifndef QNDEFNFCSMARTPOSTERRECORD_H
#define QNDEFNFCSMARTPOSTERRECORD_H

public import qt.QtCore.QList;
public import qt.QtNfc.qnfcglobal;
public import qt.QtNfc.QNdefRecord;
public import qt.QtNfc.qndefnfctextrecord;
public import qt.QtNfc.qndefnfcurirecord;

QT_FORWARD_DECLARE_CLASS(QUrl)

QT_BEGIN_NAMESPACE

class QNdefNfcSmartPosterRecordPrivate;

#define Q_DECLARE_ISRECORDTYPE_FOR_MIME_NDEF_RECORD(className) \
    QT_BEGIN_NAMESPACE \
    template<> /+inline+/ bool QNdefRecord::isRecordType<className>() const\
    { \
        return (typeNameFormat() == QNdefRecord::Mime); \
    } \
    QT_END_NAMESPACE

#define Q_DECLARE_MIME_NDEF_RECORD(className, initialPayload) \
    className() : QNdefRecord(QNdefRecord::Mime, "") { setPayload(initialPayload); } \
    className(ref const(QNdefRecord) other) : QNdefRecord(other, QNdefRecord::Mime) { }

class Q_NFC_EXPORT QNdefNfcIconRecord : public QNdefRecord
{
public:
    Q_DECLARE_MIME_NDEF_RECORD(QNdefNfcIconRecord, QByteArray(0, char(0)))

    void setData(ref const(QByteArray) data);
    QByteArray data() const;
};

class Q_NFC_EXPORT QNdefNfcSmartPosterRecord : public QNdefRecord
{
public:
    enum Action {
        UnspecifiedAction = -1,
        DoAction = 0,
        SaveAction = 1,
        EditAction = 2
    };

    QNdefNfcSmartPosterRecord();
    QNdefNfcSmartPosterRecord(ref const(QNdefRecord) other);
    QNdefNfcSmartPosterRecord(ref const(QNdefNfcSmartPosterRecord) other);
    ~QNdefNfcSmartPosterRecord();

    void setPayload(ref const(QByteArray) payload);

    bool hasTitle(ref const(QString) locale = QString()) const;
    bool hasAction() const;
    bool hasIcon(ref const(QByteArray) mimetype = QByteArray()) const;
    bool hasSize() const;
    bool hasTypeInfo() const;

    int titleCount() const;
    QNdefNfcTextRecord titleRecord(const int index) const;
    QString title(ref const(QString) locale = QString()) const;
    QList<QNdefNfcTextRecord> titleRecords() const;

    bool addTitle(ref const(QNdefNfcTextRecord) text);
    bool addTitle(ref const(QString) text, ref const(QString) locale, QNdefNfcTextRecord::Encoding encoding);
    bool removeTitle(ref const(QNdefNfcTextRecord) text);
    bool removeTitle(ref const(QString) locale);
    void setTitles(ref const(QList<QNdefNfcTextRecord>) titles);

    QUrl uri() const;
    QNdefNfcUriRecord uriRecord() const;
    void setUri(ref const(QNdefNfcUriRecord) url);
    void setUri(ref const(QUrl) url);

    Action action() const;
    void setAction(Action act);

    int iconCount() const;
    QNdefNfcIconRecord iconRecord(const int index) const;
    QByteArray icon(ref const(QByteArray) mimetype = QByteArray()) const;

    QList<QNdefNfcIconRecord> iconRecords() const;

    void addIcon(ref const(QNdefNfcIconRecord) icon);
    void addIcon(ref const(QByteArray) type, ref const(QByteArray) data);
    bool removeIcon(ref const(QNdefNfcIconRecord) icon);
    bool removeIcon(ref const(QByteArray) type);
    void setIcons(ref const(QList<QNdefNfcIconRecord>) icons);

    quint32 size() const;
    void setSize(quint32 size);

    QByteArray typeInfo() const;
    void setTypeInfo(ref const(QByteArray) type);

private:
    QSharedDataPointer<QNdefNfcSmartPosterRecordPrivate> d;

    void cleanup();
    void convertToPayload();

    bool addTitleInternal(ref const(QNdefNfcTextRecord) text);
    void addIconInternal(ref const(QNdefNfcIconRecord) icon);
};

QT_END_NAMESPACE

Q_DECLARE_ISRECORDTYPE_FOR_NDEF_RECORD(QNdefNfcSmartPosterRecord, QNdefRecord::NfcRtd, "Sp")
Q_DECLARE_ISRECORDTYPE_FOR_MIME_NDEF_RECORD(QNdefNfcIconRecord)

#endif // QNDEFNFCSMARTPOSTERRECORD_H
