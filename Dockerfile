FROM alpine:3.13.5

WORKDIR /app

RUN apk update && \
    apk add --no-cache bash \
    make automake gcc subversion python3-dev \
    musl-dev libffi-dev openssl-dev \
    curl dpkg \
    --no-cache jpeg-dev zlib-dev zlib \
    cairo \
    cairo-dev pango-dev \
    openssl-dev rust tcl-dev tiff-dev tk-dev \
    cargo freetype-dev gdk-pixbuf-dev \
    jpeg-dev lcms2-dev  openjpeg-dev poppler-utils py-cffi && \
    apk add --update py3-pip

# install psycopg2 dependencies
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev



RUN pip install --upgrade pip  
RUN pip install psycopg2-binary

COPY requirements.txt .

RUN pip install -r requirements.txt --ignore-installed

COPY . .

EXPOSE 8000

CMD python3 manage.py migrate && python3 manage.py runserver 0.0.0.0:8000
