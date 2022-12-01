FROM python:3.11-alpine@sha256:a651419779f8b2a0dbd6c46dd238d7309b01ec65164bcce51a680fc868415eea

# create privileged user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# create working directory
RUN mkdir /usr/app && chown appuser:appgroup /usr/app

# set working directory
WORKDIR /usr/app

# change active user
USER appuser

# install dependecies
COPY --chown=appuser:appgroup requirements.txt .
RUN pip install -r requirements.txt

# copy rest of files
COPY --chown=appuser:appgroup  . .

# expose port
EXPOSE 8000

# start server
CMD [ "python", "main.py" ]

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl -f http://localhost:8000/health