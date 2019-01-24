# frozen_string_literal: true

shared_examples_for 'sshd_config_subsystem resource' do
  it { is_expected.to have_sshd_config_subsystem_resource_count(1) }

  it do
    is_expected.to contain_sshd_config_subsystem('sftp').only_with('name' => 'sftp',
                                                                   'ensure'    => 'present',
                                                                   'command'   => '/usr/lib/openssh/sftp-server',
                                                                   'provider'  => 'augeas')
  end
end

shared_context 'sshd_config_subsystem' do
  it { is_expected.to have_sshd_config_subsystem_resource_count(0) }

  let :example_params do
    { 'sftp' => { 'command' => '/usr/lib/openssh/sftp-server' } }
  end

  context 'when sshd_config_subsystem_hash is a Hash' do
    let(:params) { { sshd_config_subsystem_hash: example_params } }
    let(:facts) { {} }

    include_examples 'sshd_config_subsystem resource'
  end

  context 'when ::augeasproviders_sshd_config_subsystem_hash is a Hash' do
    let(:params) { {} }
    let(:facts) { { augeasproviders_sshd_config_subsystem_hash: example_params } }

    include_examples 'sshd_config_subsystem resource'
  end
end
