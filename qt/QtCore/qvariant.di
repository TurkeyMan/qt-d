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

public import QtCore.qatomic;
public import QtCore.qbytearray;
public import QtCore.qlist;
public import QtCore.qmetatype;
public import QtCore.qmap;
public import QtCore.qhash;
public import QtCore.qstring;
public import QtCore.qstringlist;
public import QtCore.qobject;
#ifndef QT_BOOTSTRAPPED
public import QtCore.qbytearraylist;
#endif


extern(C++) class QBitArray;
extern(C++) class QDataStream;
extern(C++) class QDate;
extern(C++) class QDateTime;
extern(C++) class QEasingCurve;
extern(C++) class QLine;
extern(C++) class QLineF;
extern(C++) class QLocale;
extern(C++) class QMatrix;
extern(C++) class QTransform;
extern(C++) class QStringList;
extern(C++) class QTime;
extern(C++) class QPoint;
extern(C++) class QPointF;
extern(C++) class QSize;
extern(C++) class QSizeF;
extern(C++) class QRect;
extern(C++) class QRectF;
#ifndef QT_NO_REGEXP
extern(C++) class QRegExp;
#endif // QT_NO_REGEXP
#ifndef QT_NO_REGULAREXPRESSION
extern(C++) class QRegularExpression;
#endif // QT_NO_REGULAREXPRESSION
extern(C++) class QTextFormat;
extern(C++) class QTextLength;
extern(C++) class QUrl;
extern(C++) class QVariant;
extern(C++) class QVariantComparisonHelper;

template <typename T>
/+inline+/ QVariant qVariantFromValue(ref const(T) );

template<typename T>
/+inline+/ T qvariant_cast(ref const(QVariant) );

namespace QtPrivate {

    template <typename Derived, typename Argument, typename ReturnType>
    struct ObjectInvoker
    {
        static ReturnType invoke(Argument a)
        {
            return Derived::object(a);
        }
    }

    template <typename Derived, typename Argument, typename ReturnType>
    struct MetaTypeInvoker
    {
        static ReturnType invoke(Argument a)
        {
            return Derived::metaType(a);
        }
    }

    template <typename Derived, typename T, typename Argument, typename ReturnType, bool = IsPointerToTypeDerivedFromQObject<T>::Value>
    struct TreatAsQObjectBeforeMetaType : ObjectInvoker<Derived, Argument, ReturnType>
    {
    }

    template <typename Derived, typename T, typename Argument, typename ReturnType>
    struct TreatAsQObjectBeforeMetaType<Derived, T, Argument, ReturnType, false> : MetaTypeInvoker<Derived, Argument, ReturnType>
    {
    }

    template<typename T> struct QVariantValueHelper;
}

extern(C++) class export QVariant
{
 public:
    enum Type {
        Invalid = QMetaType::UnknownType,
        Bool = QMetaType::Bool,
        Int = QMetaType::Int,
        UInt = QMetaType::UInt,
        LongLong = QMetaType::LongLong,
        ULongLong = QMetaType::ULongLong,
        Double = QMetaType::Double,
        Char = QMetaType::QChar,
        Map = QMetaType::QVariantMap,
        List = QMetaType::QVariantList,
        String = QMetaType::QString,
        StringList = QMetaType::QStringList,
        ByteArray = QMetaType::QByteArray,
        BitArray = QMetaType::QBitArray,
        Date = QMetaType::QDate,
        Time = QMetaType::QTime,
        DateTime = QMetaType::QDateTime,
        Url = QMetaType::QUrl,
        Locale = QMetaType::QLocale,
        Rect = QMetaType::QRect,
        RectF = QMetaType::QRectF,
        Size = QMetaType::QSize,
        SizeF = QMetaType::QSizeF,
        Line = QMetaType::QLine,
        LineF = QMetaType::QLineF,
        Point = QMetaType::QPoint,
        PointF = QMetaType::QPointF,
        RegExp = QMetaType::QRegExp,
        RegularExpression = QMetaType::QRegularExpression,
        Hash = QMetaType::QVariantHash,
        EasingCurve = QMetaType::QEasingCurve,
        Uuid = QMetaType::QUuid,
        ModelIndex = QMetaType::QModelIndex,
        LastCoreType = QMetaType::LastCoreType,

        Font = QMetaType::QFont,
        Pixmap = QMetaType::QPixmap,
        Brush = QMetaType::QBrush,
        Color = QMetaType::QColor,
        Palette = QMetaType::QPalette,
        Image = QMetaType::QImage,
        Polygon = QMetaType::QPolygon,
        Region = QMetaType::QRegion,
        Bitmap = QMetaType::QBitmap,
        Cursor = QMetaType::QCursor,
        KeySequence = QMetaType::QKeySequence,
        Pen = QMetaType::QPen,
        TextLength = QMetaType::QTextLength,
        TextFormat = QMetaType::QTextFormat,
        Matrix = QMetaType::QMatrix,
        Transform = QMetaType::QTransform,
        Matrix4x4 = QMetaType::QMatrix4x4,
        Vector2D = QMetaType::QVector2D,
        Vector3D = QMetaType::QVector3D,
        Vector4D = QMetaType::QVector4D,
        Quaternion = QMetaType::QQuaternion,
        PolygonF = QMetaType::QPolygonF,
        Icon = QMetaType::QIcon,
        LastGuiType = QMetaType::LastGuiType,

        SizePolicy = QMetaType::QSizePolicy,

        UserType = QMetaType::User,
        LastType = 0xffffffff // need this so that gcc >= 3.4 allocates 32 bits for Type
    }

    /+inline+/ QVariant();
    ~QVariant();
    QVariant(Type type);
    QVariant(int typeId, const(void)* copy);
    QVariant(int typeId, const(void)* copy, uint flags);
    QVariant(ref const(QVariant) other);

#ifndef QT_NO_DATASTREAM
    QVariant(QDataStream &s);
#endif

    QVariant(int i);
    QVariant(uint ui);
    QVariant(qlonglong ll);
    QVariant(qulonglong ull);
    QVariant(bool b);
    QVariant(double d);
    QVariant(float f);
#ifndef QT_NO_CAST_FROM_ASCII
    QT_ASCII_CAST_WARN QVariant(const(char)* str);
#endif

    QVariant(ref const(QByteArray) bytearray);
    QVariant(ref const(QBitArray) bitarray);
    QVariant(ref const(QString) string);
    QVariant(QLatin1String string);
    QVariant(ref const(QStringList) stringlist);
    QVariant(QChar qchar);
    QVariant(ref const(QDate) date);
    QVariant(ref const(QTime) time);
    QVariant(ref const(QDateTime) datetime);
    QVariant(ref const(QList<QVariant>) list);
    QVariant(ref const(QMap<QString,QVariant>) map);
    QVariant(ref const(QHash<QString,QVariant>) hash);
#ifndef QT_NO_GEOM_VARIANT
    QVariant(ref const(QSize) size);
    QVariant(ref const(QSizeF) size);
    QVariant(ref const(QPoint) pt);
    QVariant(ref const(QPointF) pt);
    QVariant(ref const(QLine) line);
    QVariant(ref const(QLineF) line);
    QVariant(ref const(QRect) rect);
    QVariant(ref const(QRectF) rect);
#endif
    QVariant(ref const(QLocale) locale);
#ifndef QT_NO_REGEXP
    QVariant(ref const(QRegExp) regExp);
#endif // QT_NO_REGEXP
#ifndef QT_BOOTSTRAPPED
#ifndef QT_NO_REGULAREXPRESSION
    QVariant(ref const(QRegularExpression) re);
#endif // QT_NO_REGULAREXPRESSION
    QVariant(ref const(QUrl) url);
    QVariant(ref const(QEasingCurve) easing);
    QVariant(ref const(QUuid) uuid);
    QVariant(ref const(QModelIndex) modelIndex);
    QVariant(ref const(QJsonValue) jsonValue);
    QVariant(ref const(QJsonObject) jsonObject);
    QVariant(ref const(QJsonArray) jsonArray);
    QVariant(ref const(QJsonDocument) jsonDocument);
#endif // QT_BOOTSTRAPPED

    QVariant& operator=(ref const(QVariant) other);
#ifdef Q_COMPILER_RVALUE_REFS
    /+inline+/ QVariant(QVariant &&other) : d(other.d)
    { other.d = Private(); }
    /+inline+/ QVariant &operator=(QVariant &&other)
    { qSwap(d, other.d); return *this; }
#endif

    /+inline+/ void swap(QVariant &other) { qSwap(d, other.d); }

    Type type() const;
    int userType() const;
    const(char)* typeName() const;

    bool canConvert(int targetTypeId) const;
    bool convert(int targetTypeId);

    /+inline+/ bool isValid() const;
    bool isNull() const;

    void clear();

    void detach();
    /+inline+/ bool isDetached() const;

    int toInt(bool *ok = 0) const;
    uint toUInt(bool *ok = 0) const;
    qlonglong toLongLong(bool *ok = 0) const;
    qulonglong toULongLong(bool *ok = 0) const;
    bool toBool() const;
    double toDouble(bool *ok = 0) const;
    float toFloat(bool *ok = 0) const;
    qreal toReal(bool *ok = 0) const;
    QByteArray toByteArray() const;
    QBitArray toBitArray() const;
    QString toString() const;
    QStringList toStringList() const;
    QChar toChar() const;
    QDate toDate() const;
    QTime toTime() const;
    QDateTime toDateTime() const;
    QList<QVariant> toList() const;
    QMap<QString, QVariant> toMap() const;
    QHash<QString, QVariant> toHash() const;

#ifndef QT_NO_GEOM_VARIANT
    QPoint toPoint() const;
    QPointF toPointF() const;
    QRect toRect() const;
    QSize toSize() const;
    QSizeF toSizeF() const;
    QLine toLine() const;
    QLineF toLineF() const;
    QRectF toRectF() const;
#endif
    QLocale toLocale() const;
#ifndef QT_NO_REGEXP
    QRegExp toRegExp() const;
#endif // QT_NO_REGEXP
#ifndef QT_BOOTSTRAPPED
#ifndef QT_NO_REGULAREXPRESSION
    QRegularExpression toRegularExpression() const;
#endif // QT_NO_REGULAREXPRESSION
    QUrl toUrl() const;
    QEasingCurve toEasingCurve() const;
    QUuid toUuid() const;
    QModelIndex toModelIndex() const;
    QJsonValue toJsonValue() const;
    QJsonObject toJsonObject() const;
    QJsonArray toJsonArray() const;
    QJsonDocument toJsonDocument() const;
#endif // QT_BOOTSTRAPPED

#ifndef QT_NO_DATASTREAM
    void load(QDataStream &ds);
    void save(QDataStream &ds) const;
#endif
    static const(char)* typeToName(int typeId);
    static Type nameToType(const(char)* name);

    void *data();
    const(void)* constData() const;
    /+inline+/ const(void)* data() const { return constData(); }

    template<typename T>
    /+inline+/ void setValue(ref const(T) value);

    template<typename T>
    /+inline+/ T value() const
    { return qvariant_cast<T>(*this); }

    template<typename T>
    static /+inline+/ QVariant fromValue(ref const(T) value)
    { return qVariantFromValue(value); }

    template<typename T>
    bool canConvert() const
    { return canConvert(qMetaTypeId<T>()); }

 public:
#ifndef Q_QDOC
    struct PrivateShared
    {
        /+inline+/ PrivateShared(void *v) : ptr(v), ref(1) { }
        void *ptr;
        QAtomicInt ref;
    }
    struct Private
    {
        /+inline+/ Private(): type(Invalid), is_shared(false), is_null(true)
        { data.ptr = 0; }

        // Internal constructor for initialized variants.
        explicit /+inline+/ Private(uint variantType)
            : type(variantType), is_shared(false), is_null(false)
        {}

        /+inline+/ Private(ref const(Private) other)
            : data(other.data), type(other.type),
              is_shared(other.is_shared), is_null(other.is_null)
        {}
        union Data
        {
            char c;
            uchar uc;
            short s;
            signed char sc;
            ushort us;
            int i;
            uint u;
            long l;
            ulong ul;
            bool b;
            double d;
            float f;
            qreal real;
            qlonglong ll;
            qulonglong ull;
            QObject *o;
            void *ptr;
            PrivateShared *shared;
        } data;
        uint type : 30;
        uint is_shared : 1;
        uint is_null : 1;
    }
 public:
    typedef void (*f_construct)(Private *, const(void)* );
    typedef void (*f_clear)(Private *);
    typedef bool (*f_null)(const(Private)* );
#ifndef QT_NO_DATASTREAM
    typedef void (*f_load)(Private *, QDataStream &);
    typedef void (*f_save)(const(Private)* , QDataStream &);
#endif
    typedef bool (*f_compare)(const(Private)* , const(Private)* );
    typedef bool (*f_convert)(const QVariant::Private *d, int t, void *, bool *);
    typedef bool (*f_canConvert)(const QVariant::Private *d, int t);
    typedef void (*f_debugStream)(QDebug, ref const(QVariant) );
    struct Handler {
        f_construct construct;
        f_clear clear;
        f_null isNull;
#ifndef QT_NO_DATASTREAM
        f_load load;
        f_save save;
#endif
        f_compare compare;
        f_convert convert;
        f_canConvert canConvert;
        f_debugStream debugStream;
    }
#endif

    /+inline+/ bool operator==(ref const(QVariant) v) const
    { return cmp(v); }
    /+inline+/ bool operator!=(ref const(QVariant) v) const
    { return !cmp(v); }
    /+inline+/ bool operator<(ref const(QVariant) v) const
    { return compare(v) < 0; }
    /+inline+/ bool operator<=(ref const(QVariant) v) const
    { return compare(v) <= 0; }
    /+inline+/ bool operator>(ref const(QVariant) v) const
    { return compare(v) > 0; }
    /+inline+/ bool operator>=(ref const(QVariant) v) const
    { return compare(v) >= 0; }

protected:
    friend /+inline+/ bool operator==(ref const(QVariant) , ref const(QVariantComparisonHelper) );
#ifndef QT_NO_DEBUG_STREAM
    friend export QDebug operator<<(QDebug, ref const(QVariant) );
#endif
// ### Qt6: FIXME: Remove the special Q_CC_MSVC handling, it was introduced to maintain BC for QTBUG-41810 .
#if !defined(Q_NO_TEMPLATE_FRIENDS) && !defined(Q_CC_MSVC)
    template<typename T>
    friend /+inline+/ T qvariant_cast(ref const(QVariant) );
    template<typename T> friend struct QtPrivate::QVariantValueHelper;
protected:
#else
public:
#endif
    Private d;
    void create(int type, const(void)* copy);
    bool cmp(ref const(QVariant) other) const;
    int compare(ref const(QVariant) other) const;
    bool convert(const int t, void *ptr) const;

private:
    // force compile error, prevent QVariant(bool) to be called
    /+inline+/ QVariant(void *) Q_DECL_EQ_DELETE;
    // QVariant::Type is marked as \obsolete, but we don't want to
    // provide a constructor from its intended replacement,
    // QMetaType::Type, instead, because the idea behind these
    // constructors is flawed in the first place. But we also don't
    // want QVariant(QMetaType::String) to compile and falsely be an
    // int variant, so delete this constructor:
    QVariant(QMetaType::Type) Q_DECL_EQ_DELETE;

    // These constructors don't create QVariants of the type associcated
    // with the enum, as expected, but they would create a QVariant of
    // type int with the value of the enum value.
    // Use QVariant v = QColor(Qt.red) instead of QVariant v = Qt.red for
    // example.
    QVariant(Qt.GlobalColor) Q_DECL_EQ_DELETE;
    QVariant(Qt.BrushStyle) Q_DECL_EQ_DELETE;
    QVariant(Qt.PenStyle) Q_DECL_EQ_DELETE;
    QVariant(Qt.CursorShape) Q_DECL_EQ_DELETE;
#ifdef QT_NO_CAST_FROM_ASCII
    // force compile error when implicit conversion is not wanted
    /+inline+/ QVariant(const(char)* ) Q_DECL_EQ_DELETE;
#endif
public:
    typedef Private DataPtr;
    /+inline+/ DataPtr &data_ptr() { return d; }
    /+inline+/ ref const(DataPtr) data_ptr() const { return d; }
}

template <typename T>
/+inline+/ QVariant qVariantFromValue(ref const(T) t)
{
    return QVariant(qMetaTypeId<T>(), &t, QTypeInfo<T>::isPointer);
}

template <>
/+inline+/ QVariant qVariantFromValue(ref const(QVariant) t) { return t; }

template <typename T>
/+inline+/ void qVariantSetValue(QVariant &v, ref const(T) t)
{
    //if possible we reuse the current QVariant private
    const uint type = qMetaTypeId<T>();
    QVariant::Private &d = v.data_ptr();
    if (v.isDetached() && (type == d.type || (type <= uint(QVariant::Char) && d.type <= uint(QVariant::Char)))) {
        d.type = type;
        d.is_null = false;
        T *old = reinterpret_cast<T*>(d.is_shared ? d.data.shared->ptr : &d.data.ptr);
        if (QTypeInfo<T>::isComplex)
            old->~T();
        new (old) T(t); //call the copy constructor
    } else {
        v = QVariant(type, &t, QTypeInfo<T>::isPointer);
    }
}

template <>
/+inline+/ void qVariantSetValue<QVariant>(QVariant &v, ref const(QVariant) t)
{
    v = t;
}


/+inline+/ QVariant::QVariant() {}
/+inline+/ bool QVariant::isValid() const { return d.type != Invalid; }

template<typename T>
/+inline+/ void QVariant::setValue(ref const(T) avalue)
{ qVariantSetValue(*this, avalue); }

#ifndef QT_NO_DATASTREAM
export QDataStream& operator>> (QDataStream& s, QVariant& p);
export QDataStream& operator<< (QDataStream& s, ref const(QVariant) p);
export QDataStream& operator>> (QDataStream& s, QVariant::Type& p);
export QDataStream& operator<< (QDataStream& s, const QVariant::Type p);
#endif

/+inline+/ bool QVariant::isDetached() const
{ return !d.is_shared || d.data.shared->ref.load() == 1; }


#ifdef Q_QDOC
    /+inline+/ bool operator==(ref const(QVariant) v1, ref const(QVariant) v2);
    /+inline+/ bool operator!=(ref const(QVariant) v1, ref const(QVariant) v2);
#else

/* Helper extern(C++) class to add one more level of indirection to prevent
   implicit casts.
*/
extern(C++) class QVariantComparisonHelper
{
public:
    /+inline+/ QVariantComparisonHelper(ref const(QVariant) var)
        : v(&var) {}
private:
    friend /+inline+/ bool operator==(ref const(QVariant) , ref const(QVariantComparisonHelper) );
    const(QVariant)* v;
}

/+inline+/ bool operator==(ref const(QVariant) v1, ref const(QVariantComparisonHelper) v2)
{
    return v1.cmp(*v2.v);
}

/+inline+/ bool operator!=(ref const(QVariant) v1, ref const(QVariantComparisonHelper) v2)
{
    return !operator==(v1, v2);
}
#endif

extern(C++) class export QSequentialIterable
{
    QtMetaTypePrivate::QSequentialIterableImpl m_impl;
public:
    struct export const_iterator
    {
    private:
        QtMetaTypePrivate::QSequentialIterableImpl m_impl;
        QAtomicInt *ref;
        friend extern(C++) class QSequentialIterable;
        explicit const_iterator(ref const(QSequentialIterable) iter, QAtomicInt *ref_);

        explicit const_iterator(ref const(QtMetaTypePrivate::QSequentialIterableImpl) impl, QAtomicInt *ref_);

        void begin();
        void end();
    public:
        ~const_iterator();

        const_iterator(ref const(const_iterator) other);

        const_iterator& operator=(ref const(const_iterator) other);

        const QVariant operator*() const;
        bool operator==(ref const(const_iterator) o) const;
        bool operator!=(ref const(const_iterator) o) const;
        const_iterator &operator++();
        const_iterator operator++(int);
        const_iterator &operator--();
        const_iterator operator--(int);
        const_iterator &operator+=(int j);
        const_iterator &operator-=(int j);
        const_iterator operator+(int j) const;
        const_iterator operator-(int j) const;
    }

    friend struct const_iterator;

    explicit QSequentialIterable(QtMetaTypePrivate::QSequentialIterableImpl impl);

    const_iterator begin() const;
    const_iterator end() const;

    QVariant at(int idx) const;
    int size() const;

    bool canReverseIterate() const;
}

extern(C++) class export QAssociativeIterable
{
    QtMetaTypePrivate::QAssociativeIterableImpl m_impl;
public:
    struct export const_iterator
    {
    private:
        QtMetaTypePrivate::QAssociativeIterableImpl m_impl;
        QAtomicInt *ref;
        friend extern(C++) class QAssociativeIterable;
        explicit const_iterator(ref const(QAssociativeIterable) iter, QAtomicInt *ref_);

        explicit const_iterator(ref const(QtMetaTypePrivate::QAssociativeIterableImpl) impl, QAtomicInt *ref_);

        void begin();
        void end();
        // ### Qt 5.5: make find() (1st one) a member function
        friend void find(const_iterator &it, ref const(QVariant) key);
        friend const_iterator find(ref const(QAssociativeIterable) iterable, ref const(QVariant) key);
    public:
        ~const_iterator();
        const_iterator(ref const(const_iterator) other);

        const_iterator& operator=(ref const(const_iterator) other);

        const QVariant key() const;

        const QVariant value() const;

        const QVariant operator*() const;
        bool operator==(ref const(const_iterator) o) const;
        bool operator!=(ref const(const_iterator) o) const;
        const_iterator &operator++();
        const_iterator operator++(int);
        const_iterator &operator--();
        const_iterator operator--(int);
        const_iterator &operator+=(int j);
        const_iterator &operator-=(int j);
        const_iterator operator+(int j) const;
        const_iterator operator-(int j) const;
    }

    friend struct const_iterator;

    explicit QAssociativeIterable(QtMetaTypePrivate::QAssociativeIterableImpl impl);

    const_iterator begin() const;
    const_iterator end() const;
private: // ### Qt 5.5: make it a public find() member function:
    friend const_iterator find(ref const(QAssociativeIterable) iterable, ref const(QVariant) key);
public:

    QVariant value(ref const(QVariant) key) const;

    int size() const;
}

#ifndef QT_MOC
namespace QtPrivate {
    template<typename T>
    struct QVariantValueHelper : TreatAsQObjectBeforeMetaType<QVariantValueHelper<T>, T, ref const(QVariant) , T>
    {
        static T metaType(ref const(QVariant) v)
        {
            const int vid = qMetaTypeId<T>();
            if (vid == v.userType())
                return *reinterpret_cast<const(T)* >(v.constData());
            T t;
            if (v.convert(vid, &t))
                return t;
            return T();
        }
#ifndef QT_NO_QOBJECT
        static T object(ref const(QVariant) v)
        {
            return qobject_cast<T>(QMetaType::typeFlags(v.userType()) & QMetaType::PointerToQObject
                ? v.d.data.o
                : QVariantValueHelper::metaType(v));
        }
#endif
    }

    template<typename T>
    struct QVariantValueHelperInterface : QVariantValueHelper<T>
    {
    }

    template<>
    struct QVariantValueHelperInterface<QSequentialIterable>
    {
        static QSequentialIterable invoke(ref const(QVariant) v)
        {
            const int typeId = v.userType();
            if (typeId == qMetaTypeId<QVariantList>()) {
                return QSequentialIterable(QtMetaTypePrivate::QSequentialIterableImpl(reinterpret_cast<const QVariantList*>(v.constData())));
            }
            if (typeId == qMetaTypeId<QStringList>()) {
                return QSequentialIterable(QtMetaTypePrivate::QSequentialIterableImpl(reinterpret_cast<const QStringList*>(v.constData())));
            }
#ifndef QT_BOOTSTRAPPED
            if (typeId == qMetaTypeId<QByteArrayList>()) {
                return QSequentialIterable(QtMetaTypePrivate::QSequentialIterableImpl(reinterpret_cast<const QByteArrayList*>(v.constData())));
            }
#endif
            return QSequentialIterable(v.value<QtMetaTypePrivate::QSequentialIterableImpl>());
        }
    }
    template<>
    struct QVariantValueHelperInterface<QAssociativeIterable>
    {
        static QAssociativeIterable invoke(ref const(QVariant) v)
        {
            const int typeId = v.userType();
            if (typeId == qMetaTypeId<QVariantMap>()) {
                return QAssociativeIterable(QtMetaTypePrivate::QAssociativeIterableImpl(reinterpret_cast<const QVariantMap*>(v.constData())));
            }
            if (typeId == qMetaTypeId<QVariantHash>()) {
                return QAssociativeIterable(QtMetaTypePrivate::QAssociativeIterableImpl(reinterpret_cast<const QVariantHash*>(v.constData())));
            }
            return QAssociativeIterable(v.value<QtMetaTypePrivate::QAssociativeIterableImpl>());
        }
    }
    template<>
    struct QVariantValueHelperInterface<QVariantList>
    {
        static QVariantList invoke(ref const(QVariant) v)
        {
            const int typeId = v.userType();
            if (QtMetaTypePrivate::isBuiltinSequentialType(typeId) || QMetaType::hasRegisteredConverterFunction(typeId, qMetaTypeId<QtMetaTypePrivate::QSequentialIterableImpl>())) {
                QSequentialIterable iter = QVariantValueHelperInterface<QSequentialIterable>::invoke(v);
                QVariantList l;
                l.reserve(iter.size());
                for (QSequentialIterable::const_iterator it = iter.begin(), end = iter.end(); it != end; ++it)
                    l << *it;
                return l;
            }
            return QVariantValueHelper<QVariantList>::invoke(v);
        }
    }
    template<>
    struct QVariantValueHelperInterface<QVariantHash>
    {
        static QVariantHash invoke(ref const(QVariant) v)
        {
            const int typeId = v.userType();
            if (QtMetaTypePrivate::isBuiltinAssociativeType(typeId) || QMetaType::hasRegisteredConverterFunction(typeId, qMetaTypeId<QtMetaTypePrivate::QAssociativeIterableImpl>())) {
                QAssociativeIterable iter = QVariantValueHelperInterface<QAssociativeIterable>::invoke(v);
                QVariantHash l;
                l.reserve(iter.size());
                for (QAssociativeIterable::const_iterator it = iter.begin(), end = iter.end(); it != end; ++it)
                    l.insert(it.key().toString(), it.value());
                return l;
            }
            return QVariantValueHelper<QVariantHash>::invoke(v);
        }
    }
    template<>
    struct QVariantValueHelperInterface<QVariantMap>
    {
        static QVariantMap invoke(ref const(QVariant) v)
        {
            const int typeId = v.userType();
            if (QtMetaTypePrivate::isBuiltinAssociativeType(typeId) || QMetaType::hasRegisteredConverterFunction(typeId, qMetaTypeId<QtMetaTypePrivate::QAssociativeIterableImpl>())) {
                QAssociativeIterable iter = QVariantValueHelperInterface<QAssociativeIterable>::invoke(v);
                QVariantMap l;
                for (QAssociativeIterable::const_iterator it = iter.begin(), end = iter.end(); it != end; ++it)
                    l.insert(it.key().toString(), it.value());
                return l;
            }
            return QVariantValueHelper<QVariantMap>::invoke(v);
        }
    }
    template<>
    struct QVariantValueHelperInterface<QPair<QVariant, QVariant> >
    {
        static QPair<QVariant, QVariant> invoke(ref const(QVariant) v)
        {
            const int typeId = v.userType();
            if (typeId == qMetaTypeId<QPair<QVariant, QVariant> >())
                return QVariantValueHelper<QPair<QVariant, QVariant> >::invoke(v);

            if (QMetaType::hasRegisteredConverterFunction(typeId, qMetaTypeId<QtMetaTypePrivate::QPairVariantInterfaceImpl>())) {
                QtMetaTypePrivate::QPairVariantInterfaceImpl pi = v.value<QtMetaTypePrivate::QPairVariantInterfaceImpl>();

                const QtMetaTypePrivate::VariantData d1 = pi.first();
                QVariant v1(d1.metaTypeId, d1.data, d1.flags);
                if (d1.metaTypeId == qMetaTypeId<QVariant>())
                    v1 = *reinterpret_cast<const QVariant*>(d1.data);

                const QtMetaTypePrivate::VariantData d2 = pi.second();
                QVariant v2(d2.metaTypeId, d2.data, d2.flags);
                if (d2.metaTypeId == qMetaTypeId<QVariant>())
                    v2 = *reinterpret_cast<const QVariant*>(d2.data);

                return QPair<QVariant, QVariant>(v1, v2);
            }
            return QVariantValueHelper<QPair<QVariant, QVariant> >::invoke(v);
        }
    }
}

template<typename T> /+inline+/ T qvariant_cast(ref const(QVariant) v)
{
    return QtPrivate::QVariantValueHelperInterface<T>::invoke(v);
}

template<> /+inline+/ QVariant qvariant_cast<QVariant>(ref const(QVariant) v)
{
    if (v.userType() == QMetaType::QVariant)
        return *reinterpret_cast<const(QVariant)* >(v.constData());
    return v;
}

#if QT_DEPRECATED_SINCE(5, 0)
template<typename T>
/+inline+/ QT_DEPRECATED T qVariantValue(ref const(QVariant) variant)
{ return qvariant_cast<T>(variant); }

template<typename T>
/+inline+/ QT_DEPRECATED bool qVariantCanConvert(ref const(QVariant) variant)
{ return variant.template canConvert<T>(); }
#endif

#endif
Q_DECLARE_SHARED(QVariant)

#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug, ref const(QVariant) );
export QDebug operator<<(QDebug, const QVariant::Type);
#endif

#endif // QVARIANT_H
