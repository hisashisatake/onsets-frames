# Dual-Objective Piano Transcription

- 元ネタ

    https://qiita.com/burugaria7/items/4005724c5d1b5228327e

    この内容をDockerfileに落とし込んでみました。

    - 参照

        https://magenta.tensorflow.org/onsets-frames

- 使い方

    Dockerfileを配置したディレクトリに移動して、以下のコマンドでビルド

        $ docker build -t magenta ./


    ビルドが終わったら、docker runで実行できます。

        $ docker run -v [任意のフルパス]:/opt/wav magenta [任意の.wavファイル名]

    .wavファイルをホストとコンテナで共有するために、VOLUMEを使います。
    
    任意のフルパスはVOLUMEの実体となり、その中に.wavファイルを配置して解析させます。任意の.wavファイル名を省略した場合、デフォルトでmagenta.wavを参照します。

    - 例) 任意のフルパスを~/docker/magenta/wavにする
        
        あらかじめ、~/docker/magenta/wavにmagenta.wavを配置して、以下のコマンドを実行します。

            $ docker run -v ~/docker/magenta/wav:/opt/wav magenta

        解析が開始され、~/docker/magenta/wav上にmagenta.wav.midiが生成されます。

    - 例) 任意の.wavファイル名を指定する

        任意のフルパスは~/docker/magenta/wavとして、任意の.wavファイル名を指定します。あらかじめ、~/docker/magenta/wav上に.wavファイルを配置します。

              $ docker run -v ~/docker/magenta/wav:/opt/wav magenta example.wav

        解析が開始され、~/docker/magenta/wav上にexample.wav.midiが生成されます。